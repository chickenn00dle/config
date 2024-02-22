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
set backupcopy=yes
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
Plug 'github/copilot.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'rcarriga/nvim-dap-ui'
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


-- DAP, DAP UI
local dap = require("dap")
local dapui = require("dapui")

dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = {  os.getenv("HOME") .. '/vscode-php-debug/out/phpDebug.js' }
}
dap.configurations.php = {
	{
		type = 'php',
		request = 'launch',
		name = 'Listen for Xdebug',
		port = 9003
	}
}

dapui.setup{}
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

keymap.set('n', '<F5>', function() dap.continue() end)
keymap.set('n', '<Right>', function() dap.step_over() end)
keymap.set('n', '<Down>', function() dap.step_into() end)
keymap.set('n', '<Up>', function() dap.step_out() end)
keymap.set('n', '<Leader>b', function() dap.toggle_breakpoint() end)
keymap.set('n', '<Leader>B', function() dap.set_breakpoint() end)
keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
keymap.set('n', '<Leader>dl', function() dap.run_last() end)
keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)


-- LSP
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
lspconfig.bashls.setup{ capabilities = capabilities }
lspconfig.cssls.setup{ capabilities = capabilities }
lspconfig.eslint.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})
lspconfig.phpactor.setup{ capabilities = capabilities }
lspconfig.pyright.setup{ capabilities = capabilities }

keymap.set('n', 'gn', vim.diagnostic.goto_next)
keymap.set('n', 'gp', vim.diagnostic.goto_prev)
keymap.set('n', '<space>e', vim.diagnostic.open_float)
keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function()
		local bufopts = { noremap=true, silent=true, buffer=bufnr }
		keymap.set('n', 'ca', vim.lsp.buf.code_action, bufopts)
		keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		keymap.set('n', 'cf', vim.lsp.buf.format, bufopts)
		keymap.set('n', 'rn', vim.lsp.buf.rename, bufopts)
		keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
	end,
})


-- NvimTree
opt.termguicolors=true

map('n', '<leader>n', ':NvimTreeToggle<CR>')
map('n', 'gf', ':NvimTreeFindFile<space>')
map('n', '<leader>c', ':NvimTreeCollapse<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')

local function open_nvim_tree()
	require("nvim-tree.api").tree.open()
end

api.nvim_create_autocmd({"VimEnter"}, {callback=open_nvim_tree})

require("nvim-tree").setup({
	on_attach=function(bufnr)
		local api = require('nvim-tree.api')

		local function opts(desc)
			return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
		vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
		vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
		vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
		vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
		vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
		vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
		vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
		vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
		vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
		vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
		vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
		vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
		vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
		vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
		vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
		vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
		vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
		vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
		vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
		vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
		vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
		vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
		vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
		vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
		vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
		vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
		vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
		vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
		vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
		vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
		vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
		vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
		vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
		vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
		vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
		vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
		vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
		vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
		vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
		vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
		vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
		vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
		vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
		vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
		vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
		vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
		vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
		vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
		vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
		vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
		vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
		vim.keymap.set('n', '<leader>mn', require('nvim-tree.api').marks.navigate.next)
		vim.keymap.set('n', '<leader>mp', require('nvim-tree.api').marks.navigate.prev)
		vim.keymap.set('n', '<leader>ms', require('nvim-tree.api').marks.navigate.select)
		vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
	end,
	filters={
		git_ignored=false,
	},
	hijack_cursor=true,
	hijack_unnamed_buffer_when_opening=true,
	reload_on_bufenter=true,
	renderer={
		group_empty=true,
		highlight_git=false,
		highlight_opened_files='all',
		highlight_modified='all',
		icons={
			git_placement='after',
			modified_placement='after',
		},
		root_folder_label=false,
	},
	modified={
		enable=true,
	},
	view={
		width={
			min=20,
			max=50,
		},
	},
})


-- Telescope
local builtin = require('telescope.builtin')
local utils = require('telescope.utils')

keymap.set('n', '<leader>ff', builtin.find_files, {})
keymap.set('n', '<leader>fg', function() builtin.live_grep({cwd=utils.buffer_dir()}) end)
keymap.set('n', '<leader>fb', builtin.buffers, {})
keymap.set('n', '<leader>fh', builtin.help_tags, {})
