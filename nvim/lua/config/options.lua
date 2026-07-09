-- Editor options (converted from the old `set` blocks).
-- Note: `filetype plugin indent on`, `syntax on`, and `encoding=utf-8` are
-- Neovim defaults and were dropped.

local opt = vim.opt

-- UI / display
opt.termguicolors = true
opt.number = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.showcmd = true
opt.showmatch = true
opt.showmode = false
opt.title = true
opt.wrap = true
opt.scrolloff = 999
opt.list = true
opt.listchars = { tab = '→ ', trail = '•' }
opt.guifont = 'Menlo Regular:h18'
opt.shortmess:append('c')

-- Behavior
opt.mouse = 'a'
opt.hidden = true
opt.clipboard = 'unnamed'
opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
opt.backspace = { 'indent', 'eol', 'start' }
opt.matchpairs:append('<:>')
opt.foldmethod = 'indent'
opt.modelines = 0
opt.updatetime = 300
opt.shellcmdflag = '-ic'

-- Bells
opt.errorbells = false
opt.visualbell = true

-- Wildmenu
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.wildignore = { 'dist/*', 'vendor/*', 'node_modules/*', '.git/*' }

-- Tabs / indentation
opt.autoindent = true
opt.copyindent = true
opt.expandtab = false
opt.shiftround = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.path = (vim.env.PWD or vim.fn.getcwd()) .. '/**'

-- Backup / swap / undo
opt.backup = false
opt.writebackup = false
opt.backupcopy = 'yes'
opt.swapfile = false
opt.undofile = true
opt.undolevels = 9999
opt.undodir = vim.fn.stdpath('config') .. '/undo'
