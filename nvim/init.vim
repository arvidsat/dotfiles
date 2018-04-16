" Set language for neovim
" language en_US

" REMAPS
let mapleader = "," " Remap leader to ,

" NAVIGATION
" Center cursor when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" Move short hops with shift-jk
" nnoremap <M-j> 5j
" nnoremap <M-k> 5k
" Change windows width ctrl-hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Refactor word under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
set inccommand=nosplit " Live updating when refactoring

" Remove trailing white spaces
nnoremap <leader>w :%s/\s\+$//e<CR>


" PLUGINS
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-dispatch' " dispatch asynchronous commands

" Git goodies
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

Plug 'sheerun/vim-polyglot' " Better syntax highligting for a bunch of languages

" Search
Plug 'ctrlpvim/ctrlp.vim'   " Fuzzy file search
Plug 'mileszs/ack.vim'      " Search in files

" Statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'

Plug 'w0rp/ale' " asynchronous linting

Plug 'tpope/vim-commentary'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-surround'

Plug 'editorconfig/editorconfig-vim'

Plug 'mhinz/vim-startify'

Plug 'machakann/vim-highlightedyank'

Plug 'Yggdroot/indentline'

Plug 'jiangmiao/auto-pairs'

" Colorschemes
Plug 'morhetz/gruvbox'
Plug 'fcpg/vim-farout'

call plug#end()

" START PLUGIN CONFIGURATIONS

" fugitive
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Git checkout -b<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" deoplete and mucomplete
let g:deoplete#enable_at_startup=1
let g:deoplete#file#enable_buffer_path=1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" ale
let g:ale_linters={'javascript': ['eslint']} " Only use eslint

" ctrlp
let g:ctrlp_custom_ignore='node_modules\|DS_Store\|git\|.happypack\|es5\|dist'
let g:ctrlp_show_hidden=1
let g:ctrlp_working_path_mode=0

" ultisnips
let g:UltiSnipsExpandTrigger="<c-s>"
" let g:UltiSnipsJumpForwardTrigger = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'
set runtimepath+=~/.vim/CustomSnippets
let g:UltiSnipsSnippetsDir="~/.vim/CustomSnippets/UltiSnips"
let g:UltiSnipsEditSplit="vertical"

" airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1

" nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>no :NERDTreeFocus<CR>
" Automatically close vim if nerdtree is the only open window
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1 " Show dotfiles
let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen=1

" easymotion
nmap s <Plug>(easymotion-overwin-f)

" editorconfig
" To make it play nice with fugitive
let g:EditorConfig_exclude_patterns=['fugitive://.*']

" END PLUGIN CONFIGURATIONS

if (has("termguicolors"))
 set termguicolors
endif
set background=dark
" let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

set clipboard=unnamedplus      " Use the systems clipboard
set number relativenumber
set numberwidth=5

set scrolloff=8            " Show context around cursor

set ignorecase
set smartcase
set expandtab              " Use spaces instead of tabs.
set softtabstop=2         " Tab key indents by 2 spaces.
set shiftwidth=2         " >> indents by 2 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set hidden                 " Switch between buffers without having to save first.

set showmode               " Show current mode in command-line.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.

set wrapscan               " Searches wrap around end-of-file.
set report=0         " Always report changed lines.

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars='tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars='tab:> ,extends:>,precedes:<,nbsp:.'
endif

au FocusGained * :checktime " Automatically read file when gaining focus

" Adds functionality to see difference in buffer from disk (DiffSaved)
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Show syntax highlighting groups for word under cursor
nmap <leader>hg :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
