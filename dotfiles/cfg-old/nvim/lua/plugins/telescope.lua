return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{
			"<leader>ff",
			"<cmd>Telescope find_files<CR>",
			desc = "Find Files",
		},
		{
			"<leader>fa",
			"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
			desc = "Find All Files",
		},
		{
			"<leader>fg",
			"<cmd>Telescope live_grep<CR>",
			desc = "Live Grep",
		},
		{
			"<leader>fb",
			"<cmd>Telescope buffers<CR>",
			desc = "List Buffers",
		},
		{
			"<leader>fh",
			"<cmd>Telescope help_tags<CR>",
			desc = "Find Help",
		},
		{
			"<leader>fo",
			"<cmd>Telescope oldfiles<CR>",
			desc = "Find Old Files",
		},
		{
			"<leader>f:",
			"<cmd>Telescope commands<CR>",
			desc = "Find Commands",
		},
		{
			"<leader>fk",
			"<cmd>Telescope keymaps<CR>",
			desc = "List Keymaps",
		},
		{
			"<leader>ft",
			"<cmd>Telescope colorscheme<CR>",
			desc = "List colorschemes",
		},
		{
			"<leader>gc",
			"<cmd>Telescope git_commits<CR>",
			desc = "List Git Commits",
		},
		{
			"<leader>fc",
			function()
				require("telescope.builtin").find_files({
					prompt_title = "Neovim Config",
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "Find Neovim Config Files",
		},
	},
	opts = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local h_pct = 0.90
		local w_pct = 0.80

		telescope.setup({
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					flex = { flip_columns = 100 },
					horizontal = {
						mirror = false,
						prompt_position = "top",
						width = function(_, cols, _)
							return math.floor(cols * w_pct)
						end,
						height = function(_, _, rows)
							return math.floor(rows * h_pct)
						end,
						preview_cutoff = 10,
						preview_width = 0.5,
					},
					vertical = {
						mirror = true,
						prompt_position = "top",
						width = function(_, cols, _)
							return math.floor(cols * w_pct)
						end,
						height = function(_, _, rows)
							return math.floor(rows * h_pct)
						end,
						preview_cutoff = 10,
						preview_height = 0.5,
					},
				},
			},
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
				buffers = {
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer + actions.move_to_top,
						},
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("fidget")
	end,
}
