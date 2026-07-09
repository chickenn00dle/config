return {
	'vim-airline/vim-airline',
	dependencies = { 'vim-airline/vim-airline-themes' },
	lazy = false,
	-- g: vars must be set before airline loads.
	init = function()
		local g = vim.g
		g.airline_theme = 'minimalist'
		g['airline#extensions#tabline#enabled'] = 1
		g['airline#extensions#tabline#formatter'] = 'unique_tail'
		g['airline#extensions#tabline#buffers_label'] = ''
		g['airline#extensions#tabline#tabs_label'] = ''
		g['airline#extensions#tabline#buffer_idx_mode'] = 1
	end,
	config = function()
		local map = vim.keymap.set
		for i = 1, 9 do
			map('n', '<leader>' .. i, '<Plug>AirlineSelectTab' .. i, { silent = true })
		end
		map('n', '<leader>0', '<Plug>AirlineSelectTab10', { silent = true })
		map('n', '<leader>-', '<Plug>AirlineSelectPrevTab', { silent = true })
		map('n', '<leader>+', '<Plug>AirlineSelectNextTab', { silent = true })
	end,
}
