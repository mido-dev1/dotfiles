return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/neodev.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local neodev = require("neodev")

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"clangd",
				"emmet_language_server",
				"jsonls",
				"cssls",
				"tsserver",
				"taplo",
				"html",
				"bashls",
				"pyright",
			},
		})

		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					-- apply whatever logic you want (in this example, we'll only use null-ls)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
				async = true,
			})
		end

		local on_attach = function(client, bufnr)
			local attach_opts = { silent = true, buffer = bufnr, remap = false }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, attach_opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, attach_opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, attach_opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, attach_opts)
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, attach_opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, attach_opts)
			vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, attach_opts)
			vim.keymap.set("n", "gl", vim.diagnostic.setqflist, attach_opts)
			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, attach_opts)
			vim.keymap.set({ "n", "x" }, "gf", function()
				lsp_formatting(bufnr)
			end, attach_opts)
			vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, attach_opts)
			vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, attach_opts)
			vim.keymap.set("n", "gn", vim.diagnostic.goto_next, attach_opts)
			-- highlight words
			if client.server_capabilities.documentHighlightProvider then
				local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})

				vim.opt.updatetime = 500

				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					group = group,
					callback = function()
						vim.lsp.buf.document_highlight()
					end,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved" }, {
					buffer = bufnr,
					group = group,
					callback = function()
						vim.lsp.buf.clear_references()
					end,
				})
			end

			-- if client.supports_method("textDocument/formatting") then
			-- 	vim.api.nvim_clear_autocmds({ buffer = bufnr })
			-- 	vim.api.nvim_create_autocmd("BufWritePre", {
			-- 		buffer = bufnr,
			-- 		callback = function()
			-- 			lsp_formatting(bufnr)
			-- 		end,
			-- 	})
			-- end
		end

		-- nvim-cmp supports additional completion capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
		lspconfig["clangd"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
		})
		lspconfig["emmet_language_server"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		lspconfig["jsonls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		lspconfig["cssls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		lspconfig["tsserver"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		lspconfig["taplo"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		lspconfig["html"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		lspconfig["bashls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		lspconfig["pyright"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		neodev.setup({})
	end,
}
