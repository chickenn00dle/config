-----------------
-- Initialization
-----------------
vim.g.mapleader = ','
vim.cmd([[
	syntax on
	filetype plugin indent on
	colorscheme custom
]])

----------
-- General
----------

vim.opt.backspace=indent,eol,start
vim.opt.clipboard=unnamed
vim.opt.completeopt=menu,menuone,noinsert,noselect
vim.opt.cursorline=true
vim.opt.encoding=utf8
vim.opt.foldmethod=indent
vim.opt.guifont=Menlo\ Regular:h18
vim.opt.hidden=true
vim.opt.list=true
vim.opt.listchars=tab:→\ ,trail:•
vim.opt.matchpairs+=<:>
vim.opt.modelines=0
vim.opt.mouse=a
vim.opt.noerrorbells=true
vim.opt.noshowmode=true
vim.opt.nowritebackup=true
vim.opt.number=true
vim.opt.scrolloff=999
vim.opt.shellcmdflag=-ic
vim.opt.signcolumn=yes
vim.opt.shortmess+=c
vim.opt.showcmd=true
vim.opt.showmatch=true
vim.opt.title=true
vim.opt.updatetime=300
vim.opt.visualbell=true
vim.opt.wildignore=dist/*,vendor/*,node_modules/*,.git/*
vim.opt.wildmenu=true
vim.opt.wildmode=longest:full,full
vim.opt.wrap=true

-- Tabs/Indentation
vim.opt.autoindent=true
vim.opt.copyindent=true
vim.opt.noexpandtab=true
vim.opt.shiftround=true
vim.opt.shiftwidth=4
vim.opt.softtabstop=4
vim.opt.tabstop=4

-- Search
vim.opt.hlsearch=true
vim.opt.ignorecase=true
vim.opt.incsearch=true
vim.opt.path=$PWD/**
vim.opt.smartcase=true

-- Undo
vim.opt.nobackup=true
vim.opt.noswapfile=true
vim.opt.undofile=true
vim.opt.undodir="$XDG_CONFIG_HOME/nvim/undo"
vim.opt.undolevels=9999


-----------
-- Key Maps
-----------

function map(mode, shortcut, command)
	local map = vim.api.nvim_set_keymap
	map(mode, shortcut, command, { noremap = true, silent = true })
end

map('n', ';', ':')
map('i', 'jj', '<Esc>')

-- Swap panes
map('', '<C-h>', '<C-w>h')
map('', '<C-j>', '<C-w>j')
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')

-- Move code blocks
map('n', '<S-A-j>', ':m+<CR>==')
map('n', '<S-A-k>', ':m-2<CR>==')
map('i', '<S-A-j>', '<Esc>:m+<CR>==gi')
map('i', '<S-A-k>', '<Esc>:m-2<CR>==gi')
map('v', '<S-A-j>', ":m'>+<CR>gv=gv")
map('n', '<S-A-k>', ':m-2<CR>gv=gv')

-- Space to fold/collapse code blocks
map('n', '<silent> <Space>', '@=(foldlevel('.')?'za':'\<Space>')<CR>')
map('v', '<Space>', 'zf')


----------
-- Plugins
----------

-- Install Plugged if not already installed
if empty(glob("$XDG_CONFIG_HOME/nvim/autoload/plug.vim"))
	silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
	Plug 'editorconfig/editorconfig-vim'
	Plug 'github/copilot.vim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'preservim/nerdtree'
	Plug 'tomtom/tcomment_vim'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-vinegar'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'vim-scripts/matchit.zip'
vim.call('plug#end')

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- Install any uninstalled plugins
if len(filter(values(vim.g.plugs), '!isdirectory(v:val.dir)'))
	au VimEnter * PlugInstall --sync | source $MYVIMRC
endif


-- Airline
vim.g.airline_theme='minimalist'
vim.g.airline#extensions#ale#enabled=1
vim.g.airline#extensions#tabline#enabled=1
vim.g.airline#extensions#tabline#formatter='unique_tail'
vim.g.airline#extensions#tabline#buffers_label=''
vim.g.airline#extensions#tabline#tabs_label=''
vim.g.airline#extensions#tabline#buffer_idx_mode=1

map('n', '<leader>1', '<Plug>AirlineSelectTab1')
map('n', '<leader>2', '<Plug>AirlineSelectTab2')
map('n', '<leader>3', '<Plug>AirlineSelectTab3')
map('n', '<leader>4', '<Plug>AirlineSelectTab4')
map('n', '<leader>5', '<Plug>AirlineSelectTab5')
map('n', '<leader>6', '<Plug>AirlineSelectTab6')
map('n', '<leader>7', '<Plug>AirlineSelectTab7')
map('n', '<leader>8', '<Plug>AirlineSelectTab8')
map('n', '<leader>9', '<Plug>AirlineSelectTab9')
map('n', '<leader>0', '<Plug>AirlineSelectTab10')
map('n', '<leader>-', '<Plug>AirlineSelectPrevTab')
map('n', '<leader>+', '<Plug>AirlineSelectNextTab')

-- Fugitive
vim.g.github_enterprise_urls = ['https://github.tumblr.net']

-- LSP
require'lspconfig'.tsserver.setup{}

-- NerdTree
vim.g.NERDTreeAutoDeleteBuffer=1
vim.g.NERDTreeBookmarksFile=expand("$XDG_CONFIG_HOME/nvim/.NERDTreeBookmarks")
vim.g.NERDTreeDirArrowExpandable='▸'
vim.g.NERDTreeDirArrowCollapsible='▾'
vim.g.NERDTreeMinimalUI=1
vim.g.NERDTreeShowBookmarks=1
vim.g.NERDTreeShowHidden=1
vim.g.NERDTreeWinSize=50

vim.opt.norelativenumber
vim.opt.conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained

map('', '<leader>n', ':NERDTreeToggle<CR>')
map('', '<leader>f', ':NERDTreeFind<Space>')
