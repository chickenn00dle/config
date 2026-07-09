return {
	'praem90/nvim-phpcsf',
	ft = 'php',
	config = function()
		require('phpcs').setup{
			phpcs = os.getenv('HOME') .. '/.composer/vendor/bin/phpcs',
			phpcbf = os.getenv('HOME') .. '/.composer/vendor/bin/phpcbf',
			standard = 'wordpress',
		}

		local group = vim.api.nvim_create_augroup('PHBSCF', {})
		vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
			group = group,
			pattern = '*.php',
			callback = function()
				require('phpcs').cs()
			end,
		})

		vim.keymap.set('n', 'phpf', function()
			require('phpcs').cbf({ force = true })
		end, { silent = true })

		-- Lint the buffer that triggered loading (its BufReadPost already fired).
		require('phpcs').cs()
	end,
}
