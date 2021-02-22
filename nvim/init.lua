local utils = require('config.utils')

vim.g.mapleader = " "

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()

-- Install packer
local execute = vim.api.nvim_command

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

execute 'packadd packer.nvim'
cmd [[packadd packer.nvim]]
cmd [[autocmd BufWritePost init.lua PackerCompile]]

local packer = require('packer')
local use = packer.use
packer.startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  -- use 'airblade/vim-rooter'

  use 'nanotech/jellybeans.vim'
  use 'ayu-theme/ayu-vim'
  use 'sheerun/vim-polyglot'

  use { 
    'nvim-telescope/telescope.nvim',
    config = function() 
      require('config.telescope').setup()
      require('config.telescope').config()
    end,
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use {
    'nvim-lua/completion-nvim',
    config = require('config.completion').setup
  }

  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config= require('config.coc').config
  }

  use {
    'glepnir/galaxyline.nvim', 
    branch = 'main',
    config = function() require('config.statusline') end,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use {
    'kyazdani42/nvim-tree.lua',
    config = function() require('config.nvim_tree').setup() end,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use 'tpope/vim-commentary'
  use 'jiangmiao/auto-pairs'

  use {
    'tpope/vim-fugitive',
    config = function() require('config.fugitive') end,
  }

  use { 
    'lewis6991/gitsigns.nvim',
    config = require('config.gitsigns').setup,
    requires = {'nvim-lua/plenary.nvim'}
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  use { 'svermeulen/vim-yoink' }

  use {
    'mhinz/vim-startify',
    config = function()
      require('config.startify').config()
    end
  }

  use 'editorconfig/editorconfig-vim'

  use {
    'haya14busa/incsearch.vim',
    config = function()
      require('config.incsearch').setup()
    end
  }

  -- Lua
  use 'euclidianAce/BetterLua.vim'

  use { '~/dev/neovim/pastry.nvim' }

end)

vim.o.termguicolors = true
cmd 'colorscheme jellybeans'

vim.wo.number = true
vim.wo.relativenumber = true

local opts_info = vim.api.nvim_get_all_options_info()
local opt = setmetatable({}, {
    __newindex = function(_, key, value)
        vim.o[key] = value
        local scope = opts_info[key].scope
        if scope == "win" then
            vim.wo[key] = value
        elseif scope == "buf" then
            vim.bo[key] = value
        end
    end
})

vim.o.inccommand = 'nosplit'
vim.o.incsearch = true
vim.o.ignorecase = true -- Ignore case
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.wrapscan = true -- Search wraps at end of file
vim.o.scrolloff = 4 -- Lines of context

vim.o.hidden = true -- Enable modified buffers in background
vim.o.splitbelow = true -- Put new windows below current
vim.o.splitright = true -- Put new windows right of currentset hidden

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

if fn.isdirectory(vim.o.undodir) == 0 then fn.mkdir(vim.o.undodir, "p") end
vim.o.undofile = true -- Save undo history
vim.o.confirm = true -- prompt to save before destructive actions

vim.o.wildignore = utils.add_to_table {
    "*.aux,*.out,*.toc", "*.o,*.obj,*.dll,*.jar,*.pyc,*.rbc,*.class",
    "*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
    "*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm", "*.eot,*.otf,*.ttf,*.woff",
    "*.doc,*.pdf", "*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
    -- Cache
    "*/node_modules/*", ".sass-cache", "*/vendor/gems/*,*/vendor/cache/*",
    "*/.bundle/*,*.gem",
    -- Temp/System
    "*.*~,*~ ", "*.swp,.lock,.DS_Store,._*,tags.lock"
}

opt.autoindent = true -- Allow filetype plugins and syntax highlighting
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.tabstop = 2 -- Number of spaces tabs count for
opt.softtabstop = 2
-- vim.o.shiftround = true -- Round indent
vim.o.joinspaces = false -- No double spaces with join after a dotset 

vim.o.clipboard = 'unnamedplus'
vim.wo.signcolumn = 'yes'

vim.o.completeopt = 'menuone,noinsert,noselect' -- Completion options

vim.o.cmdheight = 2

-- Mappings
local map = utils.map


-- Move selected line / block of text in visual mode
-- shift + k to move up
-- shift + j to move down
map('x', 'K', ":move '<-2<CR>gv-gv")
map('x', 'J', ":move '>+1<CR>gv-gv")

-- Change windows with ctrl-hjkl
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<left>', '<C-w>h')
map('n', '<down>', '<C-w>j')
map('n', '<up>', '<C-w>k')
map('n', '<right>', '<C-w>l')

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

map('n', '<Leader>s', ':%s/<C-r><C-w>//g<Left><Left>')

map('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', { expr = true })
map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { expr = true })
map('i', '<C-j>', 'pumvisible() ? "<C-n>" : "<C-j>"', { expr = true })
map('i', '<C-k>', 'pumvisible() ? "<C-p>" : "<C-k>"', { expr = true })

cmd(':command! WQ wq')
cmd(':command! Wq wq')
cmd(':command! W w')
cmd(':command! Q q')

cmd('au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}')

cmd [[au CursorHold * :exec 'match Search /\V\<' . expand('<cword>') . '\>/']]
vim.o.updatetime=500

-- Set filetypes
cmd [[au BufNewFile,BufRead *.ts setlocal filetype=typescript]]
cmd [[au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx]]
cmd [[au BufNewFile,BufRead *.jsx setlocal filetype=javascript.jsx]]
