-- Non-plugin keymaps. Plugin-specific maps live in each plugin's spec.

local map = vim.keymap.set
local opts = { silent = true }

-- Quality of life
map('n', ';', ':', opts)          -- ; to enter command mode
map('i', 'jj', '<Esc>', opts)     -- jj to leave insert mode

-- Pane navigation
map('', '<C-h>', '<C-w>h', opts)
map('', '<C-j>', '<C-w>j', opts)
map('', '<C-k>', '<C-w>k', opts)
map('', '<C-l>', '<C-w>l', opts)

-- Move code blocks up/down
map('n', '<S-A-j>', ':m+<CR>==', opts)
map('n', '<S-A-k>', ':m-2<CR>==', opts)
map('i', '<S-A-j>', '<Esc>:m+<CR>==gi', opts)
map('i', '<S-A-k>', '<Esc>:m-2<CR>==gi', opts)
map('v', '<S-A-j>', ":m'>+<CR>gv=gv", opts)
map('v', '<S-A-k>', ":m'<-2<CR>gv=gv", opts)

-- Space to toggle a fold
map('n', '<Space>', 'za', opts)
map('v', '<Space>', 'za', opts)
