return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",
	opts = {
		keymap = { preset = "default" },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			menu = {
				draw = {
					-- treesitter = { "lsp" },
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" },
					},
				},
			},
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			-- list = {
			-- 	selection = {
			-- 		preselect = false,
			-- 	},
			-- },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		signature = { enabled = true },
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
