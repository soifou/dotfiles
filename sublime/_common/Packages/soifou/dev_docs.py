# search for the keyword under the scope on devdocs.io or google if language is not supposedly supported
#
# how to use: bind the "dev_docs" command to a keyboard shortcut
# put your cursor on the language keyword, function, ... you want info on
# trigger the command via the shortcut > devdocs or google is opened on your browser
#
# code is mostly http://dom111.co.uk/files/sublime/plugins/help_for_word.py
# modified to use devdocs.io as the main doc website
import sublime, sublime_plugin
import webbrowser


class DevDocsCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        devdocs_languages = ["js", "css", "html", "php", "python", "ruby"]
        devdocs_multiple_docs_languages = ["js", "ruby"]

        for region in self.view.sel():

            if region.empty():
                p = region.begin()

                # html specifics
                if self.view.scope_name(p).find('text.html.basic') > -1 and self.view.scope_name(p).find('embedded.block.html') == -1:
                    while p >= 0:
                        if self.view.substr(p) == '<' and self.view.scope_name(p).find('string.quoted.double.html') < 0:
                            p += 1

                            # check if it's an end tag
                            if self.view.substr(p) == '/':
                                p += 1

                            break

                        else:
                            p -= 1

                s = self.view.substr(self.view.word(p))

            else:
                s = self.view.substr(region)

            # purloined from: http://www.sublimetext.com/forum/viewtopic.php?f=5&t=2242
            language = self.view.scope_name(self.view.sel()[0].begin()).strip().split('.')[-1]

            # devdocs: if language has multiple docs on devdocs, we don't prepend the request with the language
            # this is useful for JS (will jquery, underscore and all other libraries) or ruby (with ror) for example
            request = s if language in devdocs_multiple_docs_languages else language + ' ' + s
            url = 'http://devdocs.io/#q=%s' if language in devdocs_languages else 'http://www.google.com/search?q=%s'
            webbrowser.open_new_tab(url % request)