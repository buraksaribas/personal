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
				"jdtls",
				"json-lsp",
				"pyright",
				"docker-compose-language-service",
				"docker-language-server",
				"yaml-language-server",
				"clangd",

				"stylua",
				"prettierd",
				"google-java-format",
				"goimports",
				"golines",
				"gopls",
				"isort",
				"black",
				"xmlformatter",
				"clang-format",
				"templ",

				"java-debug-adapter",
				"java-test",
				"debugpy",
				"codelldb",

				"prisma-language-server",
			},
			auto_update = false,
			run_on_start = true,
		},
	},
}
