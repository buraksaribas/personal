vim.keymap.set("i", "jk", "<Esc>", { desc = "" })
vim.keymap.set("i", "kj", "<Esc>", { desc = "" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "" })

vim.keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "" })
vim.keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "" })
vim.keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "" })
vim.keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "" })

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "" })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "" })

vim.keymap.set("t", "<C-Up>", "<cmd>resize -2<CR>", { desc = "" })
vim.keymap.set("t", "<C-Down>", "<cmd>resize +2<CR>", { desc = "" })
vim.keymap.set("t", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "" })
vim.keymap.set("t", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "" })

vim.keymap.set("n", "<leader>bl", "<cmd>bnext<CR>", { desc = "" })
vim.keymap.set("n", "<leader>bh", "<cmd>bprevious<CR>", { desc = "" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "" })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabprevious<CR>", { desc = "" })
vim.keymap.set("n", "<leader>th", "<cmd>tabnext<CR>", { desc = "" })

vim.keymap.set("v", "p", '"_dP')

vim.keymap.set("n", "<leader>x", function()
	local file = vim.fn.expand("%:p")
	vim.cmd("!chmod +x " .. file)
end, { desc = "Make file executable" })
