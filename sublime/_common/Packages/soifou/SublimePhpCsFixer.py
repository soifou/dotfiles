import os.path
import sublime
import sublime_plugin
import sys
import re
import subprocess
import tempfile

# Credits to:
# - https://github.com/CraigWilliams/BeautifyRuby
# - https://github.com/adael/SublimePhpCsFixer
# - https://github.com/jonlabelle/SublimeJsPrettier

PLUGIN_NAME = 'SublimePhpCsFixer'


class SublimePhpCsFixListener(sublime_plugin.EventListener):
    def on_pre_save(self, view):
        self.settings = sublime.load_settings('%s.sublime-settings' % PLUGIN_NAME)
        if self.settings.get('on_save'):
            view.run_command("sublime_php_cs_fix")


class SublimePhpCsFixCommand(sublime_plugin.TextCommand):
    def run(self, edit, error=True, save=True):
        self.load_settings()
        self.filename = self.view.file_name()
        self.fname = os.path.basename(self.filename)

        try:
            if self.is_php_file():
                self.cs_buffer(edit)

            else:
                if error:
                    raise Exception("This is not a PHP file.")
        except:
            msg = "Error: {0}".format(sys.exc_info()[1])
            sublime.error_message(msg)

    def cs_buffer(self, edit):
        # get buffered text
        file_changed = False
        buffer_region = sublime.Region(0, self.view.size())
        buffer_text = self.view.substr(buffer_region)
        if buffer_text == "":
            return

        formatted = self.format_contents(buffer_text)
        if formatted and formatted != buffer_text:
            file_changed = True
            self.view.replace(edit, buffer_region, formatted)

        if file_changed:
            sublime.set_timeout(lambda: sublime.status_message(
                '{0}: File formatted.'.format(PLUGIN_NAME)), 0)
        else:
            sublime.set_timeout(lambda: sublime.status_message(
                '{0}: File already formatted.'.format(PLUGIN_NAME)), 0)
        return

    def format_contents(self, contents):
        fd, tmp_file = tempfile.mkstemp()
        encoding = "utf8"
        with open(tmp_file, 'wb') as file:
            file.write(contents.encode(encoding))
            file.close()
        try:
            self.pipe(self.cmd(tmp_file), tmp_file)
            with open(tmp_file, 'rb') as file:
                content = file.read().decode(encoding)
                file.close()
        finally:
            os.close(fd)
            os.remove(tmp_file)
        return content

    def cmd(self, path="-"):
        php_interpreter = self.settings.get('php_path') or self.which('php.exe') or self.which('php')
        phpcsfixer = self.settings.get('path') or self.locate_php_cs_fixer()

        if php_interpreter is None:
            msg = "php interpreter not found, set PATH environment variable or set php in settings"
            raise Exception(msg)

        if phpcsfixer is None:
            msg = "php interpreter not found, set PATH environment variable or set php in settings"
            raise Exception(msg)

        args = ["--using-cache=off"]

        configs = self.settings.get('config')
        rules = self.settings.get('rules')
        if configs:
            if not type(configs) is list:
                configs = [configs]

            variables = self.get_active_window_variables()

            for config in configs:
                config_path = sublime.expand_variables(config, variables)
                if config_path.startswith("~"):
                    config_path = config_path.replace('~', os.environ["HOME"])

                if self.is_readable_file(config_path):
                    args.append('--config=' + config_path)
                    self.log_to_console("Using config: " + config_path)
                    break

        if rules:
            if isinstance(rules, list):
                rules = rules.join(",")

            if isinstance(rules, str):
                args.append("--rules=" + rules)
                self.log_to_console("Using rules: " + rules)

        self.log_to_console(php_interpreter + " '" + phpcsfixer + "' fix " + path + " " + ' '.join(args))
        return php_interpreter + " '" + phpcsfixer + "' fix " + path + " " + ' '.join(args)

    def finalize_output(self, text):
        lines = text.splitlines()
        finalized_output = "\n".join(lines)
        return finalized_output

    def load_settings(self):
        self.settings = sublime.load_settings('%s.sublime-settings' % PLUGIN_NAME)

    def save_viewport_state(self):
        self.previous_selection = [(region.a, region.b) for region in self.view.sel()]
        self.previous_position = self.view.viewport_position()

    def reset_viewport_state(self):
        self.view.set_viewport_position((0, 0,), False)
        self.view.set_viewport_position(self.previous_position, False)
        self.view.sel().clear()
        for a, b in self.previous_selection:
            self.view.sel().add(sublime.Region(a, b))

    def is_php_file(self):
        file_patterns = self.settings.get('file_patterns') or ['\.php', '\.php5']
        return self.match_pattern(file_patterns)

    def match_pattern(self, file_patterns):
        patterns = re.compile(r'\b(?:%s)\b' % '|'.join(file_patterns))
        return patterns.search(self.fname)

    def pipe(self, cmd, tmp_file):
        cwd = os.path.dirname(tmp_file)
        beautifier = subprocess.Popen(cmd, shell=True, cwd=cwd, stdout=subprocess.PIPE)
        return beautifier.communicate()

    # http://stackoverflow.com/questions/377017/test-if-executable-exists-in-python/377028#377028
    def which(self, program):
        import os

        def is_exe(fpath):
            return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

        fpath, fname = os.path.split(program)
        if fpath:
            if is_exe(program):
                return program
        else:
            for path in os.environ["PATH"].split(os.pathsep):
                path = path.strip('"')
                exe_file = os.path.join(path, program)
                if is_exe(exe_file):
                    return exe_file

        return None

    def locate_php_cs_fixer(self):
        if sublime.platform() == "windows":
            paths = self.locate_in_windows()
        else:
            paths = self.locate_in_unix()

        for path in paths:
            if self.is_executable_file(path):
                self.log_to_console("autodetected: " + path)
                return path

        self.log_to_console("php-cs-fixer not found")

    def locate_in_windows(self):
        """return possible paths for php-cs-fixer on Windows"""
        paths = []

        if "COMPOSER_HOME" in os.environ:
            paths.append(os.environ["COMPOSER_HOME"] + "\\vendor\\bin\\php-cs-fixer.bat")

        if "APPDATA" in os.environ:
            paths.append(os.environ["APPDATA"] + "\\composer\\vendor\\bin\\php-cs-fixer.bat")

        paths.append(which("php-cs-fixer.bat"))

        return paths

    def locate_in_unix(self):
        """return possible paths for php-cs-fixer on Linux and Mac"""
        paths = []

        if "COMPOSER_HOME" in os.environ:
            paths.append(os.environ["COMPOSER_HOME"] + "/vendor/bin/php-cs-fixer")

        if "HOME" in os.environ:
            paths.append(os.environ["HOME"] + "/.composer/vendor/bin/php-cs-fixer")
            paths.append(os.environ["HOME"] + "/.config/composer/vendor/bin/php-cs-fixer")

        paths.append(self.which("php-cs-fixer"))

        return paths

    def log_to_console(self, msg):
        print("{0}: {1}".format(PLUGIN_NAME, msg))

    def get_active_window_variables(self):
        variables = sublime.active_window().extract_variables()

        if 'file' in variables:
            folder = self.get_project_folder(variables['file'])
            if folder:
                variables['folder'] = folder

        return variables

    def is_executable_file(self, file_path):
        return os.path.isfile(file_path) and os.access(file_path, os.X_OK)

    def is_readable_file(self, file_path):
        return os.path.isfile(file_path) and os.access(file_path, os.R_OK)

    def get_project_folder(self, file):
        project_data = sublime.active_window().project_data()

        if not project_data:
            return None

        project_folders = project_data.get('folders', [])
        project_paths = (p['path'] for p in project_folders)
        for path in project_paths:
            if file.startswith(path):
                return path

        return None
