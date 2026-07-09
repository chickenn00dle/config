return {
	'neovim/nvim-lspconfig',
	lazy = false,
	config = function()
		-- eslint: fix all issues on save.
		local base_on_attach = vim.lsp.config.eslint.on_attach
		vim.lsp.config('eslint', {
			on_attach = function(client, bufnr)
				if not base_on_attach then return end
				base_on_attach(client, bufnr)
				vim.api.nvim_create_autocmd('BufWritePre', {
					buffer = bufnr,
					command = 'LspEslintFixAll',
				})
			end,
		})

		vim.lsp.config('intelephense', {
			settings = {
				intelephense = {
					completion = {
						insertUseDeclaration = true,
					},
					diagnostics = {
						enable = false,
					},
					environment = {
						includePaths = {
							'/Users/raz/Sites/newspack/repos/newspack-ads',
							'/Users/raz/Sites/newspack/repos/newspack-ai',
							'/Users/raz/Sites/newspack/repos/newspack-block-theme',
							'/Users/raz/Sites/newspack/repos/newspack-blocks',
							'/Users/raz/Sites/newspack/repos/newspack-e2e-tests',
							'/Users/raz/Sites/newspack/repos/newspack-listings',
							'/Users/raz/Sites/newspack/repos/newspack-manager',
							'/Users/raz/Sites/newspack/repos/newspack-manager-client',
							'/Users/raz/Sites/newspack/repos/newspack-network',
							'/Users/raz/Sites/newspack/repos/newspack-newsletters',
							'/Users/raz/Sites/newspack/repos/newspack-plugin',
							'/Users/raz/Sites/newspack/repos/newspack-popups',
							'/Users/raz/Sites/newspack/repos/newspack-scripts',
							'/Users/raz/Sites/newspack/repos/newspack-sponsors',
							'/Users/raz/Sites/newspack/repos/newspack-subscription-migrations',
							'/Users/raz/Sites/newspack/repos/newspack-theme',
							'/Users/raz/Sites/newspack/repos/republication-tracker-tool',
							'/Users/raz/Sites/newspack/repos/super-cool-ad-inserter-plugin',
						},
					},
					files = {
						maxSize = 10000000,
					},
					format = {
						enable = false,
					},
					stubs = {
						'Core',
						'standard',
						'wordpress',
						'/Users/raz/Stubs/woocommerce',
						'/Users/raz/Stubs/woocommerce-subscriptions',
					},
					maxMemory = 512,
				},
			},
		})

		vim.lsp.enable('bashls')
		vim.lsp.enable('cssls')
		vim.lsp.enable('eslint')
		vim.lsp.enable('intelephense')
		vim.lsp.enable('pyright')

		-- Diagnostics
		local map = vim.keymap.set
		map('n', 'gn', function() vim.diagnostic.jump({ count = 1 }) end)
		map('n', 'gp', function() vim.diagnostic.jump({ count = -1 }) end)
		map('n', '<space>e', vim.diagnostic.open_float)
		map('n', '<space>q', vim.diagnostic.setloclist)

		-- Buffer-local LSP keymaps on attach.
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				local bufopts = { noremap = true, silent = true, buffer = ev.buf }
				map('n', 'ca', vim.lsp.buf.code_action, bufopts)
				map('n', 'gd', vim.lsp.buf.definition, bufopts)
				map('n', 'gD', vim.lsp.buf.declaration, bufopts)
				map('n', 'gi', vim.lsp.buf.implementation, bufopts)
				map('n', 'gr', vim.lsp.buf.references, bufopts)
				map('n', 'K', vim.lsp.buf.hover, bufopts)
				map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
				map('n', 'cf', vim.lsp.buf.format, bufopts)
				map('n', 'rn', vim.lsp.buf.rename, bufopts)
				map('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
			end,
		})
	end,
}
