-- Entry point. Leader must be set before lazy.nvim maps any `keys` specs.
vim.g.mapleader = ','

require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.lazy')

-- Colorscheme lives in colors/custom.vim (not a plugin).
vim.cmd.colorscheme('custom')
