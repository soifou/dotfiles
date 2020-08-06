import sublime
import sublime_plugin
import subprocess
import re
from pprint import pprint

PLUGIN_NAME = 'Zoxide'


class Settings:
    def get(setting):
        return sublime.load_settings('%s.sublime-settings' %
                                     PLUGIN_NAME).get(setting)


class ZoxideCommand:
    def __init__(self, directory_regex):
        self.directory_regex = directory_regex

    def run(self, flags):
        try:
            zoxide_cmd = ['zoxide'] + flags + [self.directory_regex]
            output = subprocess.check_output(zoxide_cmd, shell=False)
            # print("{0}: {1}".format("zoxide", output.decode("utf-8")))
            return output.decode("utf-8")
        except subprocess.CalledProcessError as e:
            e.returncode
            if e.returncode == 1:
                return ''
            elif e.returncode == 127:
                raise Exception("zoxide not found")
            raise
        except Exception as e:
            raise

    def query(self):
        output = self.run(['query', '-l'])
        if not output:
            return None

        return output.rstrip().split('\n')


class ZoxideJumpCommand(sublime_plugin.WindowCommand):
    def run(self, menu=None, action=None):
        self.window.show_input_panel("zoxide: Directory regex", "",
                                     self.on_show_input_panel_done, None, None)

    def on_show_input_panel_done(self, directory_regex):
        zoxide = ZoxideCommand(directory_regex)
        self.mode_list(zoxide)

    def mode_list(self, zoxide):
        try:
            directory_list = zoxide.query()
            # print("{0}: {1}".format("zoxide", pprint(directory_list)))
            # print("{0}: {1}".format("zoxide", len(directory_list)))
            if directory_list:
                if len(directory_list) == 1:
                    self.open_directory(directory_list[0])
                else:
                    self.show_directories(directory_list)
            else:
                sublime.message_dialog('{0}: No matches for {1}'.format(
                    PLUGIN_NAME, zoxide.directory_regex))
        except Exception as e:
            sublime.error_message(str(e))

    def on_directory_selected(self, directory):
        if directory:
            self.open_directory(directory)

    def open_directory(self, directory):
        if self.window.project_data():
            sublime.run_command('new_window')

        sublime.active_window().set_project_data(
            {'folders': [{
                'path': directory,
                'follow_symlinks': True
            }]})

    def show_directories(self, directory_list):
        def selectedCallback(index):
            self.on_directory_selected(
                directory_list[index] if index > -1 else None)

        self.window.show_quick_panel(directory_list, selectedCallback,
                                     sublime.KEEP_OPEN_ON_FOCUS_LOST, 0, None)
