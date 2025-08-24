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
			insert = {
				a = { bg = colors.green, fg = colors.base, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.green },
			},
			visual = {
				a = { bg = colors.mauve, fg = colors.base, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.mauve },
			},
			replace = {
				a = { bg = colors.red, fg = colors.base, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.red },
			},
			command = {
				a = { bg = colors.peach, fg = colors.base, gui = "bold" },
				b = { bg = colors.surface0, fg = colors.peach },
			},
			inactive = {
				a = { bg = colors.surface0, fg = colors.lavender },
				b = { bg = colors.surface0, fg = colors.surface2, gui = "bold" },
				c = { bg = colors.mantle, fg = colors.surface2 },
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
