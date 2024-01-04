return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",

		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",

		"onsails/lspkind.nvim",
	},
	config = function()
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		local lspkind = require("lspkind")
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion

				-- ['<Tab>'] = function(fallback)
				--     if not cmp.select_next_item() then
				--         if vim.bo.buftype ~= 'prompt' and has_words_before() then
				--             cmp.complete()
				--         else
				--             fallback()
				--         end
				--     end
				-- end,
				--
				-- ['<S-Tab>'] = function(fallback)
				--     if not cmp.select_prev_item() then
				--         if vim.bo.buftype ~= 'prompt' and has_words_before() then
				--             cmp.complete()
				--         else
				--             fallback()
				--         end
				--     end
				-- end,

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- that way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				-- ['<CR>'] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_active_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol", -- text_symbol
					menu = {
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						buffer = "[Buffer]",
						path = "[PATH]",
					},
				}),
			},
		})
	end,
}
