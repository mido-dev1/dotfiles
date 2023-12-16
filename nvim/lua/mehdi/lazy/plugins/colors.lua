return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            integrations = {
                nvimtree = true,
                treesitter = true,
                treesitter_context = false,
                telescope = {
                    enabled = true,
                    style = "nvchad"
                },
                indent_blankline = {
                    enabled = true,
                    scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
                    colored_indent_levels = true,
                },
                semantic_tokens = true,
                cmp = true,
                mason = false,
            },
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
