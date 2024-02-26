return {
	"NvChad/nvterm",
	config = function()
		require("nvterm").setup()
        local term = require("nvterm.terminal")
        vim.keymap.set("n", "<Leader>t", function ()
            term.new "horizontal"
        end)
	end,
}
