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

Plugin 'arcticicestudio/nord-vim'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'docker/docker', {'rtp': '/contrib/syntax/vim/'}
Plugin 'itchyny/lightline.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rhysd/vim-gfm-syntax'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on " required

" 03. Events
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab

" In Ruby/JavaScript files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2
autocmd FileType javascript setlocal sw=2 ts=2 sts=2

" Enable omnicompletion (to use, hold Ctrl+X then Ctrl+O while in Insert mode)
set ofu=syntaxcomplete#Complete

" No swap files, use version control instead
set noswapfile

" 04. Theme/Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).

colorscheme nord
let g:lightline = {'colorscheme': 'nord'}

" custom highlight terms style (:hi to get colors depending on your scheme)
autocmd VimEnter,Colorscheme * :hi Search term=bold,reverse ctermfg=6 ctermbg=8 guifg=#88C0D0 guibg=#4C566A

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
set number                " show line numbers
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
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2

" 06. Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4               " tab spacing
set nowrap                  " don't wrap text
set shiftwidth=4            " indent/outdent by 4 columns

" set autoindent            " auto-indent
" set softtabstop=4         " unify
" set shiftround            " always indent/outdent to the nearest tabstop
" set expandtab             " use spaces instead of tabs
" set smartindent           " automatically insert one extra level of indentation
" set smarttab              " use tabs at the start of a line, spaces elsewhere

" Backspace key should delete chars (mac only)
set backspace=indent,eol,start

" 07. Custom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ALE (Asynchronous Lint Engine)
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_completion_enabled = 1

" Open FuzzyFinder with Ctrl+p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Open NERDtree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
