return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},
	{ "nvim-telescope/telescope.nvim" },

	--{ "RRethy/base16-nvim" },

	--{ "folke/tokyonight.nvim" },

	{ "catppuccin/nvim", name = "catppuccin", priority = 1000},
-- nvim v0.8.0
	--{ "ellisonleao/gruvbox.nvim" },

	--[[{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},]]

}
