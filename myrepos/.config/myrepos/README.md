# myrepos

Using [myrepos](https://myrepos.branchable.com/) only to checkout/update/status multiple repo in a row.

## Notes

Default .mrconfig file is stored directly in home directory and does not respect XDG compliance.
I have set an alias for mr command to always specify my custom location and trust everything.
Not the best but fits my needs.

```sh
alias mr="mr -c $XDG_CONFIG_HOME/myrepos/config -t"
```

## Example of my repo list

Location: `$XDG_DATA_HOME/myrepos/*.enabled`
Content is typically like below:

```
[$XDG_DEVELOP_DIR/foo/bar]
checkout = git clone 'https://github.com/x/bar' 'bar'
```

