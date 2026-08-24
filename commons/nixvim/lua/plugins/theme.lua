return {
	{ "EdenEast/nightfox.nvim" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 10000,
		config = function()
			require("catppuccin").setup({
				flavour = "latte",
				background = {
				  light = "latte",
				  dark = "latte",
				},
			})
			vim.cmd.colorscheme("catppuccin-latte")
		end,
	},
	{
		"RRethy/base16-nvim",
		config = function()
			require('matugen').setup()
		end,
	}
}

