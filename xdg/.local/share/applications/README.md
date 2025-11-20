# Desktop apps

- [Spec](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html)

## Notes

When creating a `.desktop` file, don't forget to make it executable: `chmod +x foo.dekstop`.
If you don't want to show in the list, use `NoDisplay=true`.
When clicking on a link in Firefox, it reads `~/.config/mimeapps.list` to display several apps which can handle the mimetype.

