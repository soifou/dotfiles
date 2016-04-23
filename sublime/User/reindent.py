import sublime, sublime_plugin

# pick from here https://github.com/kamilkp/Sublime-Text-ReIndent
class ReIndentToFourCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        self.view.run_command('unexpand_tabs')
        self.view.run_command('set_setting', {"setting": "tab_size", "value": 4});
        self.view.run_command('expand_tabs')