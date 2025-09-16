local augroup = vim.api.nvim_create_augroup("CustomIndent", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = {
		"javascript",
		"typescript",
		"typescriptreact",
		"javascriptreact",
		"json",
		"yaml",
		"html",
		"java",
		"css",
		"lua",
		"sh",
		"prisma",
	},
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = {
		"python",
		"go",
		"rust",
		"c",
		"cpp",
	},
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
	end,
})
