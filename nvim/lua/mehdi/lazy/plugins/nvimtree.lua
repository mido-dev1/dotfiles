return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local keymap = vim.keymap
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup {
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            view = {
                relativenumber = true,
            },
            renderer = {
                root_folder_label = false,
                group_empty = true,
                highlight_diagnostics = true,
                indent_markers = {
                    enable = true,
                },
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
            },
            modified = {
                enable = true,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                }
            }
        }
        keymap.set('n', '<leader>ee', '<cmd>NvimTreeFindFileToggle<CR>')
    end,
}
