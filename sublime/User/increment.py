import sublime, sublime_plugin

class IncrementSelectionCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        start_value = int(self.view.substr(self.view.sel()[0]))

        counter = 0
        for selection in self.view.sel():
            self.view.insert(edit, selection.begin(), str(start_value + counter))
            counter = counter + 1

        for selection in self.view.sel():
            self.view.erase(edit, selection)
