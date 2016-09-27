""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: .vimrc                                                         "
" Maintainer: Michael J. Smalley <michaeljsmalley@gmail.com>                 "
"        URL: http://github.com/michaeljsmalley/dotfiles                     "
"                                                                            "
"                                                                            "
" Sections:                                                                  "
"   01. General ................. General Vim behavior                       "
"   02. Plugins.................. Vundle                                     "
"   03. Events .................. General autocmd events                     "
"   04. Theme/Colors ............ Colors, fonts, etc.                        "
"   05. Vim UI .................. User interface behavior                    "
"   06. Text Formatting/Layout .. Text, tab, indentation related             "
"   07. Custom Commands ......... Any custom command aliases                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible         " get rid of Vi compatibility mode. SET FIRST!
set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Vundle : https://github.com/VundleVim/Vundle.Vim                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
" github repo
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'docker/docker', {'rtp': '/contrib/syntax/vim/'}

call vundle#end()
filetype plugin indent on " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Events                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab
" In Ruby/JavaScript files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2
autocmd FileType javascript setlocal sw=2 ts=2 sts=2

" Enable omnicompletion (to use, hold Ctrl+X then Ctrl+O while in Insert mode.
set ofu=syntaxcomplete#Complete
set noswapfile            " No swap files, use version control instead

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Theme/Colors                                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).

" Use the Solarized Dark theme
set background=dark
" let g:solarized_termtrans=1
" let g:solarized_termcolors=256
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
colorscheme zenburn

" Airline custom config
let g:airline_powerline_fonts = 1
let g:airline_theme = 'zenburn'
let g:airline#extensions#tabline#enabled = 1

" Prettify JSON files
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd Syntax json sou ~/.vim/syntax/json.vim

" Prettify Vagrantfile
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" Prettify Markdown files
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Vim UI                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                " show line numbers
set numberwidth=6         " make the number gutter 6 characters wide
set cul                   " highlight current line
set laststatus=2          " last window always has a statusline
set nohlsearch            " Don't continue to highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set ruler                 " Always show info along bottom.
set showmatch
set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P
set visualbell
" Enable folding
set foldmethod=indent
set foldlevel=99

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Text Formatting/Layout                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set autoindent            " auto-indent
" set tabstop=4             " tab spacing
" set softtabstop=4         " unify
" set shiftwidth=4          " indent/outdent by 2 columns
" set shiftround            " always indent/outdent to the nearest tabstop
" set expandtab             " use spaces instead of tabs
" set smartindent           " automatically insert one extra level of indentation
" set smarttab              " use tabs at the start of a line, spaces elsewhere
" set nowrap                " don't wrap text
" set backspace=2           " fix Delete (backspace) on Mac OS X
" Backspace key should delete chars (mac only)
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 07. Custom Commands                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prettify JSON files making them easier to read
command PrettyJSON %!python -m json.tool

" open FuzzyFinder with Ctrl+p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" open NERDtree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
