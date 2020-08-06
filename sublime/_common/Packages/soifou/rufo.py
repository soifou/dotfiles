import json
import os
import sublime
import sublime_plugin
import subprocess

PLUGIN_NAME = 'Rufo'


class RufoPluginListener(sublime_plugin.EventListener):
    def on_pre_save(self, view):
        settings = sublime.load_settings('sublime-rufo.sublime-settings')

        if settings.get('auto_format') == 'dotrufo':
            res = []
            for folder in self.view.window.folders():
                res.append(os.path.exists(folder + '/.rufo'))
            if any(res):
                view.run_command('rufo_format')

        if settings.get('auto_format') is not None and settings.get(
                'auto_format') is True:
            view.run_command('rufo_format')


class RufoFormatCommand(sublime_plugin.TextCommand):
    def get_env(self):
        env = {}
        env.update(os.environ)
        env['PATH'] = os.pathsep + env['PATH']
        return env

    def run(self, edit):
        self.log_to_console('Formatting with rufo...')
        filename = self.view.file_name()

        settings = sublime.load_settings('sublime-rufo.sublime-settings')
        rufo_cmd = settings.get("rufo_cmd") or "rufo"

        command = [rufo_cmd]
        if filename is not None:
            command = [rufo_cmd, filename]
            subprocess.call(command)
            sublime.set_timeout(
                lambda: sublime.status_message('{0}: File formatted.'.format(
                    PLUGIN_NAME)), 0)

    def log_to_console(self, msg):
        print("{0}: {1}".format(PLUGIN_NAME, msg))
