return {
	"stevearc/oil.nvim",
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
		{
			"benomahony/oil-git.nvim",
			opts = {
				highlights = {
					OilGitAdded = { fg = "#a6e3a1" }, -- green
					OilGitModified = { fg = "#f9e2af" }, -- yellow
					OilGitDeleted = { fg = "#f38ba8" }, -- red
					OilGitRenamed = { fg = "#cba6f7" }, -- purple
					OilGitUntracked = { fg = "#89b4fa" }, -- blue
					OilGitIgnored = { fg = "#6c7086" }, -- gray
				},
			},
		},
		{
			"JezerM/oil-lsp-diagnostics.nvim",
			dependencies = { "stevearc/oil.nvim" },
			opts = {},
		},
	},
	lazy = false,
	keys = {
		{
			"<leader>-",
			function()
				require("oil").toggle_float()
			end,
			desc = "Open File Manager in Float",
		},
		{
			"-",
			"<cmd>Oil<CR>",
			desc = "Open File Manager",
		},
	},
	opts = {
		default_file_explorer = true,
		view_options = {
			show_hidden = false,
		},
		-- win_options = {
		-- 	-- cursorline = true
		-- },
	},
}
