return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
		{ '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
		{ '<leader>fg', function()
			require('telescope.builtin').live_grep({ cwd = require('telescope.utils').buffer_dir() })
		end, desc = 'Live grep (buffer dir)' },
		{ '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Buffers' },
		{ '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Help tags' },
	},
	opts = {
		defaults = {
			file_ignore_patterns = {
				'dist/*',
				'vendor/*',
				'node_modules/*',
				'.git/*',
				'languages/*',
				'sites/*',
				'wpcloud-externals/*',
			},
		},
	},
}
