return {
	'olimorris/codecompanion.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-treesitter/nvim-treesitter',
	},
	lazy = false,
	opts = {
		interactions = {
			chat = {
				adapter = { name = 'ollama', model = 'gemma4' },
				-- Native completion has no auto-popover; open it on demand.
				-- Type / (or @, #) then press <C-x> for the completion menu.
				-- (Not <C-Space> — macOS intercepts Ctrl+Space for input sources.)
				keymaps = {
					completion = { modes = { i = '<C-x>' } },
				},
			},
			inline = { adapter = { name = 'ollama', model = 'gemma4' } },
			cmd = { adapter = { name = 'ollama', model = 'gemma4' } },
			background = { adapter = { name = 'ollama', model = 'gemma4' } },
		},
	},
}
