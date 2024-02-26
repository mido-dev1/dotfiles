return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
		"gbprod/none-ls-shellcheck.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting

		require("mason").setup({})

		mason_null_ls.setup({
			ensure_installed = {
				"cpplint",
				"pylint",

				"clang-format",
				"stylua",
				"shfmt",
				"prettier",
			},
			automatic_installation = true,
		})

		local cpplint = require("none-ls.diagnostics.cpplint")

		null_ls.setup({
			sources = {
				formatting.clang_format.with({
					extra_args = { "--style=Google" },
				}),
				formatting.stylua,
				formatting.shfmt,
				formatting.prettier,
				cpplint.with({
					diagnostic_config = {
						underline = true,
						virtual_text = false,
						signs = true,
						update_in_insert = false,
						severity_sort = true,
					},
				}),
				diagnostics.pylint,
			},
		})

		null_ls.register(require("none-ls-shellcheck.diagnostics"))
		null_ls.register(require("none-ls-shellcheck.code_actions"))
	end,
}
