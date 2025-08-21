return {
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
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
