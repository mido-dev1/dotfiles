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
		local servers = require("mehdi.lazy.servers").formatters_linters
		-- local lsp_formatting = function(bufnr)
		--     vim.lsp.buf.format({
		--         filter = function(client)
		--             -- apply whatever logic you want (in this example, we'll only use null-ls)
		--             return client.name == "null-ls"
		--         end,
		--         bufnr = bufnr,
		--     })
		-- end
		-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		mason_null_ls.setup({
			ensure_installed = servers,
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
			-- on_attach = function(client, bufnr)
			--     if client.supports_method("textDocument/formatting") then
			--         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			--         vim.api.nvim_create_autocmd("BufWritePre", {
			--             group = augroup,
			--             buffer = bufnr,
			--             callback = function()
			--                 lsp_formatting(bufnr)
			--             end,
			--         })
			--     end
			-- end,
		})
	end,
}
