" =============================================================================
" Filename: autoload/lightline/colorscheme/wal.vim
" Original Author: Dylan Araps
" Forked By: bloodflame
" License: MIT License
" =============================================================================

let s:black             = [ '#000000', 232 ]
let s:grey              = [ '#000000', 0 ]
let s:red               = [ '#000000', 1 ]
let s:green             = [ '#000000', 2 ]
let s:yellow            = [ '#000000', 3 ]
let s:blue              = [ '#000000', 4 ]
let s:magenta           = [ '#000000', 5 ]
let s:cyan              = [ '#000000', 6 ]
let s:white             = [ '#000000', 7 ]
let s:brightgrey        = [ '#000000', 8 ]
let s:brightred         = [ '#000000', 9 ]
let s:brightgreen       = [ '#000000', 10 ]
let s:brightyellow      = [ '#000000', 11 ]
let s:brightblue        = [ '#000000', 12 ]
let s:brightmagenta     = [ '#000000', 13 ]
let s:brightcyan        = [ '#000000', 14 ]
let s:brightwhite       = [ '#000000', 15 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [ [ s:black, s:brightred ],        [ s:brightcyan, s:grey ] ]
let s:p.normal.middle   = [ [ s:green, s:grey ] ]
let s:p.normal.right    = [ [ s:black, s:cyan ],        [ s:brightcyan, s:grey ] ]
let s:p.normal.error    = [ [ s:red, s:black ] ]
let s:p.normal.warning  = [ [ s:yellow, s:black ] ]

let s:p.inactive.left   = [ [ s:brightgrey, s:grey ],  [ s:brightgrey, s:grey ] ]
let s:p.inactive.middle = [ [ s:brightgrey, s:grey ] ]
let s:p.inactive.right  = [ [ s:brightgrey, s:grey ],  [ s:brightgrey, s:grey ] ]

let s:p.insert.left     = [ [ s:black, s:green ],       [ s:brightgreen, s:grey ] ]
let s:p.insert.middle   = [ [ s:green, s:grey ] ]
let s:p.insert.right    = [ [ s:black, s:green ],       [ s:brightgreen, s:grey ] ]

let s:p.replace.left    = [ [ s:black, s:red ],         [ s:brightred, s:grey ] ]
let s:p.replace.middle  = [ [ s:red, s:grey ] ]
let s:p.replace.right   = [ [ s:black, s:red ],         [ s:brightred, s:grey ] ]

let s:p.visual.left     = [ [ s:black, s:magenta ],     [ s:brightmagenta, s:grey ] ]
let s:p.visual.middle   = [ [ s:magenta, s:grey ] ]
let s:p.visual.right    = [ [ s:black, s:magenta ],     [ s:brightmagenta, s:grey ] ]

let s:p.tabline.left    = [ [ s:brightgrey, s:grey ] ]
let s:p.tabline.middle  = [ [ s:blue, s:black ] ]
let s:p.tabline.right   = [ [ s:black, s:black ],       [ s:brightwhite, s:grey ] ]
let s:p.tabline.tabsel  = [ [ s:grey, s:blue ] ]

let g:lightline#colorscheme#wal#palette = lightline#colorscheme#flatten(s:p)

