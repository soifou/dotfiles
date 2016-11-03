import sublime, sublime_plugin

from xml.etree import ElementTree as ET
import urllib, sys, os, json

GOOGLE_AC = r"http://google.com/complete/search?output=toolbar&q=%s"

# just a dummy example to override autocomplete feature
class GoogleAutocomplete(sublime_plugin.EventListener):
    def on_query_completions(self, view, prefix, locations):
        pass
        # curr_dir = os.path.abspath(os.path.dirname(__file__))
        # # elements = json.load(curr_dir + '/docs.json').read()
        # with open(curr_dir + '/docs.json') as f:
        #     elements = json.load(f)
        # sugs = [(x["version"], "") * 2 for x in elements]

        # # sys.stderr.write(elements)
        # # sublime.message_dialog(x.attrib["data"])
        # return sugs
