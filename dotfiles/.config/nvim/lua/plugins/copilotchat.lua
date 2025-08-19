return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		event = "VeryLazy",
		build = "make tiktoken",
		opts = {},
	},
}
