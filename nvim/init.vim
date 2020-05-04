" REMAPS
let mapleader = ' ' " Remap leader to space

" NAVIGATION
" Center cursor when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" Change windows width ctrl-hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

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

" Git
Plug 'tpope/vim-fugitive'
" Plug 'lambdalisue/gina.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'sheerun/vim-polyglot' " Better syntax highligting for a bunch of languages

" Search
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'      " Search in files

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Statusbar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'

" autocomplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" asynchronous linting
" go to definition
Plug 'w0rp/ale', { 'do': 'npm install -g typescript' }

Plug 'tpope/vim-commentary'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'easymotion/vim-easymotion'

Plug 'tpope/vim-surround'

Plug 'mhinz/vim-startify'

Plug 'machakann/vim-highlightedyank'

Plug 'Yggdroot/indentline'

Plug 'jacoborus/tender.vim'

call plug#end()

" START PLUGIN CONFIGURATIONS

" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
noremap <c-p> :FZF<CR>
noremap <c-s> :Ag<CR>

" indentline
let g:indentLine_setConceal=0

" fugitive
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>

" deoplete
" let g:deoplete#enable_at_startup = 1
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" ale
let g:ale_linters={'javascript': ['eslint', 'tsserver']}
nmap <leader>an <Plug>(ale_next_wrap)
nmap <leader>ap <Plug>(ale_previous_wrap)
nmap <leader>af <Plug>(ale_first)
nmap <leader>ad :ALEGoToDefinition<CR>

" ctrlp
" let g:ctrlp_custom_ignore='node_modules\|DS_Store\|git\|.happypack\|es5\|dist'
" let g:ctrlp_show_hidden=1
" let g:ctrlp_working_path_mode=0

" ultisnips
let g:UltiSnipsExpandTrigger="<c-s>"
set runtimepath+=~/.vim/CustomSnippets
let g:UltiSnipsSnippetsDir="~/.vim/CustomSnippets/UltiSnips"
let g:UltiSnipsEditSplit="vertical"

" airline
let g:airline_theme='tender'
let g:airline_powerline_fonts=1

" nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>no :NERDTreeFocus<CR>
" Automatically close vim if nerdtree is the only open window
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1 " Show dotfiles
let NERDTreeMinimalUI=1
let NERDTreeWinSize=40
" let NERDTreeQuitOnOpen=1

" easymotion
nmap s <Plug>(easymotion-overwin-f)

" startify
let g:startify_change_to_dir=0

" END PLUGIN CONFIGURATIONS

" color
if (has("termguicolors"))
  set termguicolors
endif

colorscheme tender
" hi Comment ctermfg=DarkGray

set clipboard=unnamedplus  " Use the systems clipboard
set number relativenumber
set numberwidth=5

set scrolloff=8            " Show context around cursor

set ignorecase
set smartcase
set expandtab              " Use spaces instead of tabs.
set softtabstop=2          " Tab key indents by 2 spaces.
set shiftwidth=2           " >> indents by 2 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set hidden                 " Switch between buffers without having to save first.

set showmode               " Show current mode in command-line.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.

set wrapscan               " Searches wrap around end-of-file.
set report=0               " Always report changed lines.

set nobackup
set nowritebackup

" Settings recommended by coc README
set cmdheight=2
set updatetime=300

set shortmess+=c
set signcolumn=yes

set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=node_modules/*,bower_components/*
set wildignore+=dist/*,server-dist/*

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

" Automatically create directory when saving file
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
      let dir=fnamemodify(a:file, ':h')
      if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

function ExecCurrentLineInTerminal()
  let currentline = getline('.')
  execute "!" . currentline
endfunction

nnoremap <leader>rl :call ExecCurrentLineInTerminal()<cr>
