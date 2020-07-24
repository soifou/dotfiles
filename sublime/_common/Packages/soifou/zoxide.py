# -*- coding: utf-8 -*-

import sublime
import sublime_plugin
import subprocess
import re


class Settings:
    def get(setting):
        return sublime.load_settings('zoxide.sublime-settings').get(setting)


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

    def getBestMatch(self):
        output = self.run(['query'])
        if not output:
            return None

        return output.rstrip()


class ZoxideJumpCommand(sublime_plugin.WindowCommand):
    def run(self, menu=None, action=None):
        self.mode = Settings.get('mode')
        if self.mode == 'list_all':
            self.mode_list(ZoxideCommand(''))
        else:
            self.window.show_input_panel("zoxide: Directory regex", "",
                                         self.on_show_input_panel_done, None,
                                         None)

    def on_show_input_panel_done(self, directory_regex):
        zoxide = ZoxideCommand(directory_regex)
        self.mode_best_match(zoxide)

    def mode_best_match(self, zoxide):
        try:
            directory = zoxide.getBestMatch()
            if directory:
                self.open_directory(directory)
            else:
                sublime.message_dialog('No match for {}'.format(
                    zoxide.directory_regex))
        except Exception as e:
            sublime.error_message(str(e))

    def mode_list(self, zoxide):
        try:
            directory_list = zoxide.getList()
            if directory_list:
                if len(directory_list) == 1:
                    self.open_directory(directory_list[0])
                else:
                    self.show_directories(directory_list)
            else:
                sublime.message_dialog('No matches for {}'.format(
                    zoxide.directory_regex))
        except Exception as e:
            sublime.error_message(str(e))

    def on_directory_selected(self, directory):
        if directory:
            self.open_directory(directory)

    def open_directory(self, directory):
        # print("{0}: {1}".format("zoxide", directory))
        if self.window.project_data():
            sublime.run_command('new_window')
        sublime.active_window().set_project_data({
            'folders': [{
                'path': directory,
                'follow_symlinks': True
            }]
        })

    def show_directories(self, directory_list):
        def selectedCallback(index):
            self.on_directory_selected(
                directory_list[index] if index > -1 else None)

        self.window.show_quick_panel(directory_list, selectedCallback,
                                     sublime.KEEP_OPEN_ON_FOCUS_LOST, 0, None)
