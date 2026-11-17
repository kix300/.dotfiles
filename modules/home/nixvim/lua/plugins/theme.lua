return {
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
		end,
	},
}

