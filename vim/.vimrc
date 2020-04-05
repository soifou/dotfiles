" 01. General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible         " get rid of Vi compatibility mode. SET FIRST!
set encoding=utf-8

" 02. Vundle : https://github.com/VundleVim/Vundle.Vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')

if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif

filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
if iCanHazVundle == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

" Local
Plugin 'wal.vim'

" Github
Plugin 'ap/vim-css-color'
Plugin 'arcticicestudio/nord-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'rhysd/vim-gfm-syntax'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on " required

" 03. Events
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab

" In Ruby files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2
" autocmd FileType javascript setlocal sw=2 ts=2 sts=2

" Enable omnicompletion (to use, hold Ctrl+X then Ctrl+O while in Insert mode)
set ofu=syntaxcomplete#Complete

" No swap files, use version control instead
set noswapfile

" 04. Theme/Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme wal
set t_Co=256              " enable 256-color mode.
" set termguicolors         " enable true colors support (nord/ayu need this enabled).
syntax enable             " enable syntax highlighting (previously syntax on).

" Prettify JSON files
autocmd BufRead,BufNewFile *.json set filetype=json
" Prettify Vagrantfile
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
" Prettify Markdown files
autocmd BufRead,BufNew,BufNewFile *.md set ft=markdown.gfm
" Prettify Nginx conf
au BufRead,BufNewFile */nginx/* set ft=nginx

" 05. Vim UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set number                " show line numbers
set rnu                   " show relative numbers
set numberwidth=6         " make the number gutter 6 characters wide
set cul                   " highlight current line
set laststatus=2          " last window always has a statusline
set hlsearch              " Highlight matches
set incsearch             " Highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set showmatch
set visualbell

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable indent line
" let g:indent_guides_auto_colors = 1
" let g:indent_guides_guide_size = 1
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_start_level = 2

" Split bar
set fillchars=vert:│

" 06. Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4               " tab spacing
set nowrap                  " don't wrap text
set shiftwidth=4            " indent/outdent by 4 columns

" set autoindent            " auto-indent
" set softtabstop=4         " unify
" set shiftround            " always indent/outdent to the nearest tabstop
set expandtab               " use spaces instead of tabs
" set smartindent           " automatically insert one extra level of indentation
" set smarttab              " use tabs at the start of a line, spaces elsewhere

" Backspace key should delete chars (mac only)
set backspace=indent,eol,start

" 07. Custom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
let g:lightline = { 'colorscheme': 'wal' }

" ALE (Asynchronous Lint Engine)
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_completion_enabled = 1

" Open FuzzyFinder with Ctrl+p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Devicons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" Find glyph at http://nerdfonts.com/#cheat-sheet
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
    \ 'html': '',
    \ 'css': '',
    \ 'cson': "\ue60b",
    \ 'less': "\ue758",
    \ 'md': "\ue73e"
\ }
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {
    \ '.gitignore': "\ue702",
    \ '.php_cs': "\ue608"
\ }

" NERDTree syntax highlight plugin (vim-nerdtree-syntax-highlight)
" let s:git_orange = 'F54D27'
" let s:purple = "834F79"
" let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
" let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue
" let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
" let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange
" let g:NERDTreeExactMatchHighlightColor['.php_cs'] = s:purple
" let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
" let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

" let g:NERDTreeSyntaxDisableDefaultExtensions = 1
" let g:NERDTreeFileExtensionHighlightFullName = 1
" let g:NERDTreeExactMatchHighlightFullName = 1
" let g:NERDTreePatternMatchHighlightFullName = 1

"   ~on vimrc source, refresh the devicons
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

" NERDTree
let g:NERDTreeMinimalUI = 1
let NERDTreeCascadeSingleChildDir=0
" let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
" this will enable icon specific colors set " " instead to use only one color
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = [
    \ '^\.DS_Store$[[file]]',
    \ 'zsh.zwc$[[file]]',
    \ '^\.git$[[dir]]',
    \ '^node_modules$[[dir]]'
\ ]


" Make colors of directory icons with the same as directory names.
highlight! link NERDTreeFlags NERDTreeDir
" Remove trailing slash for dirs
augroup nerdtreehidecwd
    autocmd!
    autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end
" Open with Ctrl+n
map <C-n> :NERDTreeToggle<CR>
" Open automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" mutt: insert attachment with ranger
" fun! RangerMuttAttach()
"     if filereadable('/tmp/chosendir')
"         silent !ranger --choosefiles=/tmp/chosenfiles --choosedir=/tmp/chosendir "$(cat /tmp/chosendir)"
"     else
"         silent !ranger --choosefiles=/tmp/chosenfiles --choosedir=/tmp/chosendir
"     endif
"     if filereadable('/tmp/chosenfiles')
"         call append('.', map(readfile('/tmp/chosenfiles'), '"Attach: ".substitute(v:val," ",''\\ '',"g")'))
"         call system('rm /tmp/chosenfiles')
"     endif
"     redraw!
" endfun
" map <C-a> magg/Reply-To<CR><ESC>:call RangerMuttAttach()<CR>`a
" imap <C-a> <ESC>magg/Reply-To<CR><ESC>:call RangerMuttAttach()<CR>`aa


" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap H gT " Go to prev tab
nnoremap L gt " Go to next tab
