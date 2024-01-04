return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"jay-babu/mason-null-ls.nvim",
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
				"eslint_d",

				"clang-format",
				"stylua",
				"beautysh",
				"prettier",
			},
			automatic_installation = true,
		})

		null_ls.setup({
			sources = {
				formatting.clang_format,
				formatting.stylua,
				formatting.beautysh,
				formatting.prettier,
				diagnostics.cpplint,
				diagnostics.pylint,
				diagnostics.eslint_d,
			},
		})
	end,
}
