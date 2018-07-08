import logging
import os
import sublime
import sublime_plugin
import subprocess

PLUGIN_NAME = 'PrettyDiff'

logger = logging.getLogger(__name__)


class PrettydiffBeautifyCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        # get buffered text
        file_changed = False
        buffer_region = sublime.Region(0, self.view.size())
        buffer_text = self.view.substr(buffer_region)
        if buffer_text == "":
            return

        formatted = self.format_contents()
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

    def format_contents(self):
        cmd = 'prettydiff mode:"beautify" readmethod:"filescreen" source:"' + \
            self.view.file_name() + '" '

        output = subprocess.check_output(cmd, shell=True, env=self.get_env())
        content = output.decode('utf-8')
        return content

    def get_env(self):
        env = {}
        env.update(os.environ)
        self.load_settings()
        paths = self.settings.get('paths')
        env['PATH'] = paths[sublime.platform()] + os.pathsep + env['PATH']
        return env

    def log_to_console(self, msg):
        print("{0}: {1}".format(PLUGIN_NAME, msg))

    def load_settings(self):
        self.settings = sublime.load_settings(
            '%s.sublime-settings' % PLUGIN_NAME)
