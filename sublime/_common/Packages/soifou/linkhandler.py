import sublime
import sublime_plugin
import subprocess
import threading


# Original plugin: https://github.com/leonid-shevtsov/ClickableUrls_SublimeText
class Linkhandler(sublime_plugin.EventListener):
    # Thanks Jeff Atwood http://www.codinghorror.com/blog/2008/10/the-problem-with-urls.html
    # ^ that up here is a URL that should be matched
    URL_REGEX = "\\bhttps?://[-A-Za-z0-9+&@#/%?=~_()|!:,.;']*[-A-Za-z0-9+&@#/%=~_(|]"
    DEFAULT_MAX_URLS = 200
    DEFAULT_OPENER = "linkhandler"
    SETTINGS_FILENAME = 'Linkhandler.sublime-settings'

    urls_for_view = {}
    scopes_for_view = {}
    ignored_views = []
    highlight_semaphore = threading.Semaphore()

    def on_activated(self, view):
        self.update_url_highlights(view)

    # Async listeners for ST3
    def on_load_async(self, view):
        self.update_url_highlights_async(view)

    def on_modified_async(self, view):
        self.update_url_highlights_async(view)

    def on_close(self, view):
        for map in [
                self.urls_for_view, self.scopes_for_view, self.ignored_views
        ]:
            if view.id() in map:
                del map[view.id()]

    """The logic entry point. Find all URLs in view, store and highlight them"""

    def update_url_highlights(self, view):
        settings = sublime.load_settings(Linkhandler.SETTINGS_FILENAME)

        if view.id() in Linkhandler.ignored_views:
            return

        urls = view.find_all(Linkhandler.URL_REGEX)

        # Avoid slowdowns for views with too much URLs
        if len(urls) > settings.get('max_url_limit',
                                    Linkhandler.DEFAULT_MAX_URLS):
            print("Linkhandler: ignoring view with %u URLs" % len(urls))
            Linkhandler.ignored_views.append(view.id())
            return

        Linkhandler.urls_for_view[view.id()] = urls

        if (settings.get('highlight_urls', True)):
            self.highlight_urls(view, urls)

    """Same as update_url_highlights, but avoids race conditions with a
    semaphore."""

    def update_url_highlights_async(self, view):
        Linkhandler.highlight_semaphore.acquire()
        try:
            self.update_url_highlights(view)
        finally:
            Linkhandler.highlight_semaphore.release()

    """Creates a set of regions from the intersection of urls and scopes,
    underlines all of them."""

    def highlight_urls(self, view, urls):
        # We need separate regions for each lexical scope for ST to use a proper color for the underline
        scope_map = {}
        for url in urls:
            scope_name = view.scope_name(url.a)
            scope_map.setdefault(scope_name, []).append(url)

        for scope_name in scope_map:
            self.underline_regions(view, scope_name, scope_map[scope_name])

        self.update_view_scopes(view, scope_map.keys())

    """Apply underlining with provided scope name to provided regions.
    Uses the empty region underline hack for Sublime Text 2 and native
    underlining for Sublime Text 3."""

    def underline_regions(self, view, scope_name, regions):
        if sublime.version() >= '3019':
            # in Sublime Text 3, the regions are just underlined
            view.add_regions(u'clickable-urls ' + scope_name,
                             regions,
                             scope_name,
                             flags=sublime.DRAW_NO_FILL
                             | sublime.DRAW_NO_OUTLINE
                             | sublime.DRAW_SOLID_UNDERLINE)
        else:
            # in Sublime Text 2, the 'empty region underline' hack is used
            char_regions = [
                sublime.Region(pos, pos) for region in regions
                for pos in range(region.a, region.b)
            ]
            view.add_regions(u'clickable-urls ' + scope_name, char_regions,
                             scope_name, sublime.DRAW_EMPTY_AS_OVERWRITE)

    """Store new set of underlined scopes for view. Erase underlining from
    scopes that were used but are not anymore."""

    def update_view_scopes(self, view, new_scopes):
        old_scopes = Linkhandler.scopes_for_view.get(view.id(), None)
        if old_scopes:
            unused_scopes = set(old_scopes) - set(new_scopes)
            for unused_scope_name in unused_scopes:
                view.erase_regions(u'clickable-urls ' + unused_scope_name)

        Linkhandler.scopes_for_view[view.id()] = new_scopes

    """Open URL with the correct app"""

    def open_url(url):
        try:
            # TODO: Starting from python 3.5 we can use run instead of call
            settings = sublime.load_settings(Linkhandler.SETTINGS_FILENAME)
            cmd = "{0} {1}".format(
                settings.get('browser', Linkhandler.DEFAULT_OPENER), url)
            output = subprocess.call(cmd, shell=True)

        except subprocess.CalledProcessError as e:
            e.returncode
            if e.returncode == 1:
                return ''
            elif e.returncode == 127:
                raise Exception("{} not found", cmd)
        except Exception as e:
            raise


class OpenUrlUnderCursorCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        if self.view.id() in Linkhandler.urls_for_view:
            selection = self.view.sel()[0]
            if selection.empty():
                selection = next(
                    (url for url in Linkhandler.urls_for_view[self.view.id()]
                     if url.contains(selection)), None)
                if not selection:
                    return
            url = self.view.substr(selection)
            Linkhandler.open_url(url)


class OpenAllUrlsCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        if self.view.id() in Linkhandler.urls_for_view:
            for url in set([
                    self.view.substr(url_region)
                    for url_region in Linkhandler.urls_for_view[self.view.id()]
            ]):
                print(url)
                Linkhandler.open_url(url)
