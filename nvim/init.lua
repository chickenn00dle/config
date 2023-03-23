----------
-- Globals
----------
local api = vim.api
local call = vim.call
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local keymap = vim.keymap
local opt = vim.opt


-----------------
-- Initialization
-----------------
-- g.loaded_netrw = 1
-- g.loaded_netrwPlugin = 1
g.mapleader = ','

opt.termguicolors = true
opt.syntax='on'

cmd([[
filetype plugin indent on
colorscheme custom
]])

----------
-- General
----------

cmd([[
set backspace=indent,eol,start
set clipboard=unnamed
set completeopt=menu,menuone,noinsert,noselect
set cursorline
set encoding=utf8
set foldmethod=indent
set guifont=Menlo\ Regular:h18
set hidden
set list
set listchars=tab:→\ ,trail:•
set matchpairs+=<:>
set modelines=0
set mouse=a
set noerrorbells
set noshowmode
set nowritebackup
set number
set scrolloff=999
set shellcmdflag=-ic
set signcolumn=yes
set shortmess+=c
set showcmd
set showmatch
set title
set updatetime=300
set visualbell
set wildignore=dist/*,vendor/*,node_modules/*,.git/*
set wildmenu
set wildmode=longest:full,full
set wrap
]])

-- Tabs/Indentation
cmd([[
set autoindent
set copyindent
set noexpandtab
set shiftround
set shiftwidth=4
set softtabstop=4
set tabstop=4
]])

-- Search
cmd([[
set hlsearch
set ignorecase
set incsearch
set path=$PWD/**
set smartcase
]])

-- Undo
cmd([[
set nobackup
set noswapfile
set undofile
set undodir="$XDG_CONFIG_HOME/nvim/undo"
set undolevels=9999
]])


-----------
-- Key Maps
-----------

function map(mode, shortcut, command)
	api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
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
map('n', '<Space>', 'za')
map('v', '<Space>', 'za')


----------
-- Plugins
----------

local Plug = fn['plug#']
call('plug#begin', '~/.config/nvim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'github/copilot.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/matchit.zip'
call('plug#end')

-- Airline
g.airline_theme='minimalist'
g['airline#extensions#ale#enabled']=1
g['airline#extensions#tabline#enabled']=1
g['airline#extensions#tabline#formatter']='unique_tail'
g['airline#extensions#tabline#buffers_label']=''
g['airline#extensions#tabline#tabs_label']=''
g['airline#extensions#tabline#buffer_idx_mode']=1

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
g.github_enterprise_urls={'https://github.tumblr.net'}

-- LSP
keymap.set('n', 'gp', vim.diagnostic.goto_prev, { noremap=true, silent=true })
keymap.set('n', 'gn', vim.diagnostic.goto_next, { noremap=true, silent=true })

local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	keymap.set('n', 'gD', function() vim.lsp.buf.declaration() { reuse_win=true } end, bufopts)
	keymap.set('n', 'gd', function() vim.lsp.buf.definition { reuse_win=true } end, butopts)
	keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)
	keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	keymap.set('n', 'tD', function() vim.lsp.buf.type_definition { reuse_win=true } end, bufopts)
	keymap.set('n', 'ca', vim.lsp.buf.code_action, bufopts)
	keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	keymap.set('n', 'lf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport=true

require'lspconfig'.cssls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
}

require'lspconfig'.eslint.setup({
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

require'lspconfig'.intelephense.setup{
	on_attach = on_attach,
}

require('lspconfig')['pyright'].setup{
	on_attach = on_attach,
}

require('lspconfig')['tsserver'].setup{
	on_attach = on_attach,
	handlers = {
		['textDocument/definition'] = function(err, result, method, ...)
			local function filterReactDTS(value)
				if not vim.tbl_islist(result) or type(result) ~= "table" then
					return string.match(value.uri, 'react/index.d.ts') == nil
				end

				return { result[1] }
			end

			vim.lsp.handlers['textDocument/definition'](err, filterReactDTS(result), method, ...)
			end
	},
}


-- NvimTree
opt.termguicolors=true

map('n', '<leader>n', ':NvimTreeToggle<CR>')
map('n', 'gf', ':NvimTreeFindFile<space>')
map('n', '<leader>c', ':NvimTreeCollapse<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
vim.keymap.set("n", "<leader>mn", require("nvim-tree.api").marks.navigate.next)
vim.keymap.set("n", "<leader>mp", require("nvim-tree.api").marks.navigate.prev)
vim.keymap.set("n", "<leader>ms", require("nvim-tree.api").marks.navigate.select)

local function open_nvim_tree()
	require("nvim-tree.api").tree.open()
end

api.nvim_create_autocmd({"VimEnter"}, {callback=open_nvim_tree})

require("nvim-tree").setup({
	hijack_cursor=true,
	hijack_unnamed_buffer_when_opening=true,
	reload_on_bufenter=true,
	renderer={
		group_empty=true,
		highlight_git=true,
		highlight_opened_files='all',
		highlight_modified='all',
		icons={
			git_placement='after',
			modified_placement='after',
		},
	},
	modified={
		enable=true,
	},
	view={
		hide_root_folder=true,
		mappings={
			list={
				{key="u",action="dir_up"},
			},
		},
		width={
			min=20,
			max=50,
		},
	},
})

-- Telescope
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', builtin.find_files, {})
keymap.set('n', '<leader>fg', builtin.live_grep, {})
keymap.set('n', '<leader>fb', builtin.buffers, {})
keymap.set('n', '<leader>fh', builtin.help_tags, {})
