-- Non-plugin autocmds.

-- In list-like windows, <CR> jumps to the entry and closes the window.
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'qf', 'help', 'checkhealth', 'lspinfo' },
	callback = function()
		vim.keymap.set('n', '<CR>', '<CR>:cclose<CR>', { silent = true, buffer = true })
	end,
})
