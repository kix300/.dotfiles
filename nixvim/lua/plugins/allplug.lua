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

	-- { "folke/tokyonight.nvim" },

	{ "catppuccin/nvim", lazy = true, name = "catppuccin", priority = 1000},

	{ "echasnovski/mini.nvim", enbale = false },

	{ "vague2k/huez.nvim" },

}
