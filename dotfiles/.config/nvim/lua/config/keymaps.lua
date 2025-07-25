local map = vim.keymap.set

-- ========== General Keymaps ==========

map("n", "<Space>", "<Nop>", { silent = true }) -- Unmap <Space> so it can be used as a leader
vim.g.mapleader = " " -- Set <Space> as the leader key
vim.g.maplocalleader = " " -- Set local leader key

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" }) -- Cancel search highlight with <Esc>
map("i", "jk", "<Esc>", { desc = "Exit insert mode quickly" }) -- Fast exit from insert mode

-- ========== File Operations ==========

map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
map("n", "<leader>qq", "<cmd>qall!<CR>", { desc = "Quit all without saving" })

-- ========== Window & Tab Management ==========

map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

map("n", "<C-h>", "<C-w>h", { desc = "Go left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go down window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go up window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go right window" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabprev<CR>", { desc = "Previous tab" })

-- ========== Navigation ==========

map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up and center" })
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- ========== Moving Text ==========

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- ========== Buffers ==========

map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- ========== Terminal ==========

map("n", "<leader>tt", "<cmd>split | terminal<CR>", { desc = "Open terminal in split" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ========== Diagnostics ==========

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic float" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })
