return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local builtin = require('telescope.builtin')
        local telescope = require 'telescope'
        local keymap = vim.keymap
        telescope.setup {
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                }
            }
        }
        telescope.load_extension('fzf')
        keymap.set('n', '<leader>ff', builtin.find_files, {})
        keymap.set('n', '<leader>fg', builtin.live_grep, {})
        keymap.set('n', '<leader>fb', builtin.buffers, {})
        keymap.set('n', '<leader>fh', builtin.help_tags, {})
        keymap.set('n', '<leader>fw', builtin.current_buffer_fuzzy_find, {})
        keymap.set('n', '<leader>fd', builtin.diagnostics, {})
        keymap.set('n', '<leader>ft', builtin.treesitter, {})
        keymap.set('n', '<leader>fq', builtin.quickfixhistory, {})
        keymap.set('n', '<leader>fk', builtin.keymaps, {})
    end
}
