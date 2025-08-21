return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"lua-language-server",
				"typescript-language-server",
				"html-lsp",
				"css-lsp",
				"tailwindcss-language-server",
				"gopls",
				"jdtls",
				"json-lsp",

				"stylua",
				"prettierd",
				"google-java-format",

				"java-debug-adapter",
				"java-test",
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
