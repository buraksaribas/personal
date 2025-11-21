return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				float = {
					transparent = true,
				},
				custom_highlights = function(colors)
					return {
						FloatBorder = { fg = colors.lavender },
						BlinkCmpMenuBorder = { fg = colors.lavender },
					}
				end,
				integrations = {
					treesitter = true,
					native_lsp = { enabled = true },
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("tokyonight")
		end,
	},
}
