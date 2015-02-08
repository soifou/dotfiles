import webbrowser, re
import sublime, sublime_plugin

class OpenBrowserCommand(sublime_plugin.TextCommand):
    def run(self, edit, url):
        selection = ""
        for region in self.view.sel():
            selection += self.view.substr(region)
            # debug
            #sublime.error_message(str(self.view.substr(region)))


        # fix php function
        if re.search("php.net", url):
            selection = selection.replace("_", "-")

        webbrowser.open(url % selection)