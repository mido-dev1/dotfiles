return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"williamboman/mason.nvim",
		"rcarriga/nvim-dap-ui",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		local mason_nvim_dap = require("mason-nvim-dap")
		require("mason").setup({})
		mason_nvim_dap.setup({
			ensure_installed = { "codelldb" },
			automatic_installation = true,
			handlers = {
				codelldb = function(config)
					config.configurations = {
						{
							name = "LLDB: Launch",
							type = "codelldb",
							request = "launch",
							program = function()
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end,
							cwd = "${workspaceFolder}",
							stopOnEntry = false,
							args = {
								"a",
								"b",
								"c",
							},
							-- console = "integratedTerminal",
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
		dapui.setup()
		-- codelldb setup
		-- dap.adapters.codelldb = {
		-- 	type = "server",
		-- 	port = "${port}",
		-- 	executable = {
		-- 		command = vim.fn.exepath("codelldb"),
		-- 		args = { "--port", "${port}" },
		-- 	},
		-- }

		-- dap.configurations.c = {
		-- 	{
		-- 		name = "Launch file",
		-- 		type = "codelldb",
		-- 		request = "launch",
		-- 		program = function()
		-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 		end,
		-- 		cwd = "${workspaceFolder}",
		-- 		stopOnEntry = false,
		-- 		args = {
		-- 			"a",
		-- 			"b",
		-- 		},
		-- 	},
		-- }

		-- automatic dapui
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		-- keymaps
		vim.keymap.set("n", "<F5>", function()
			dap.continue()
		end)
		vim.keymap.set("n", "<F10>", function()
			dap.step_over()
		end)
		vim.keymap.set("n", "<F11>", function()
			dap.step_into()
		end)
		vim.keymap.set("n", "<F12>", function()
			dap.step_out()
		end)
		vim.keymap.set("n", "<Leader>dt", function()
			dap.toggle_breakpoint()
		end)
		vim.keymap.set("n", "<Leader>dr", function()
			dap.repl.toggle()
		end)
		vim.keymap.set("n", "<Leader>dx", function()
			dap.disconnect()
			dap.close()
		end)
		vim.keymap.set("n", "<Leader>do", function()
			dapui.open({ reset = true })
		end)
		vim.keymap.set("n", "<Leader>dc", function()
			dapui.close()
		end)
	end,
}
