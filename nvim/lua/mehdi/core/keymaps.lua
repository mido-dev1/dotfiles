local opts = { silent = true }
local keymap = vim.keymap
-- Navigate vim windows better
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

--Remap space as leader key
keymap.set({ "n", "v" }, "<Space>", "<Nop>", opts)

-- search
keymap.set("n", "<leader>h", ":nohlsearch<CR>", opts)
keymap.set("n", "J", "mzJ`z", opts)
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- move a test in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- yank to clipboard
keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
keymap.set("n", "<leader>Y", '"+Y', opts)

-- paste from clipboard
keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)
keymap.set("n", "<leader>P", '"+P', opts)

-- Replace
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Source a file
keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- move between buffer
keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", opts)
keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", opts)
keymap.set("n", "<leader>bd", "<cmd>bd<CR>", opts)

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
