return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = require("catppuccin.palettes").get_palette("mocha")

		local catppuccin = {
			normal = {
				a = { bg = colors.lavender, fg = colors.base, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.lavender },
				c = { bg = colors.mantle, fg = colors.subtext1 },
			},
		}

		require("lualine").setup({
			options = {
				theme = catppuccin,
				section_separators = "",
				component_separators = "",
			},
		})
	end,
}
