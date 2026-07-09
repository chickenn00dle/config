return {
	'mfussenegger/nvim-dap',
	dependencies = {
		'rcarriga/nvim-dap-ui',
		'nvim-neotest/nvim-nio',
	},
	ft = 'php',
	keys = {
		{ '<Leader>dd', function() require('dap').continue() end, desc = 'DAP continue' },
		{ '<Right>', function() require('dap').step_over() end, desc = 'DAP step over' },
		{ '<Down>', function() require('dap').step_into() end, desc = 'DAP step into' },
		{ '<Up>', function() require('dap').step_out() end, desc = 'DAP step out' },
		{ '<Leader>t', function() require('dapui').toggle() end, desc = 'DAP UI toggle' },
		{ '<Leader>b', function() require('dap').toggle_breakpoint() end, desc = 'DAP breakpoint' },
		{ '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = 'DAP log point' },
		{ '<Leader>dr', function() require('dap').repl.open() end, desc = 'DAP repl' },
		{ '<Leader>dl', function() require('dap').run_last() end, desc = 'DAP run last' },
		{ '<Leader>dh', function() require('dap.ui.widgets').hover() end, mode = { 'n', 'v' }, desc = 'DAP hover' },
		{ '<Leader>dp', function() require('dap.ui.widgets').preview() end, mode = { 'n', 'v' }, desc = 'DAP preview' },
		{ '<Leader>df', function()
			local widgets = require('dap.ui.widgets')
			widgets.centered_float(widgets.frames)
		end, desc = 'DAP frames' },
		{ '<Leader>ds', function()
			local widgets = require('dap.ui.widgets')
			widgets.centered_float(widgets.scopes)
		end, desc = 'DAP scopes' },
	},
	config = function()
		local dap = require('dap')
		local dapui = require('dapui')

		dap.adapters.php = {
			type = 'executable',
			command = 'node',
			args = { os.getenv('HOME') .. '/vscode-php-debug/out/phpDebug.js' },
		}
		dap.configurations.php = {
			{
				type = 'php',
				request = 'launch',
				name = 'Listen for Xdebug',
				port = 9003,
			},
		}

		dapui.setup{}
		dap.listeners.before.attach.dapui_config = function() dapui.open() end
		dap.listeners.before.launch.dapui_config = function() dapui.open() end
		dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
		dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
	end,
}
