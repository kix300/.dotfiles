return {
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			autoformat = false,
			---@type lspconfig.options
			servers = {
				nil_ls = {},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				nix = { "nixpkgs_fmt", "injected" },
			},
		},
	},
	{
		"figsoda/nix-develop.nvim",
		event = "VeryLazy",
	},
}
