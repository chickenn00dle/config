return {
	'nvim-treesitter/nvim-treesitter',
	branch = 'main', -- the rewrite: supports Neovim 0.12+; needs the tree-sitter CLI
	-- (`brew install tree-sitter-cli`, >= 0.26.1) to compile parsers.
	lazy = false, -- nvim-treesitter does not support lazy-loading.
	build = ':TSUpdate',
	config = function()
		-- The `main` branch has no `configs.setup()` and no `highlight` module.
		-- Parsers are installed with require('nvim-treesitter').install(...),
		-- and highlighting is driven by Neovim's built-in treesitter via the
		-- FileType autocmd below. install() is async and idempotent — it no-ops
		-- when the parser is already at the locked revision.
		require('nvim-treesitter').install({ 'yaml', 'lua', 'markdown' })

		vim.api.nvim_create_autocmd('FileType', {
			pattern = { 'yaml', 'lua', 'markdown' },
			callback = function()
				pcall(vim.treesitter.start)
			end,
			desc = 'Native treesitter highlighting',
		})
	end,
}
