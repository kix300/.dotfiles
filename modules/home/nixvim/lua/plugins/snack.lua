return {
	{
		"folke/snacks.nvim",
		opts = {
			dashboard = {},
			notifier = {},
			quickfile = {},
			statuscolumn = {},
			words = {},
			styles = {
				notification = {
					wo = { wrap = true } -- Wrap notifications
				}
			},
			explorer = {
				-- Configuration pour rendre l'explorateur transparent
				win = {
					style = {
						bg = "none",
					},
				},
			},
		},
		config = function(_, opts)
			require("snacks").setup(opts)
			-- Forcer la transparence des highlights Snacks
			vim.api.nvim_set_hl(0, "SnacksNormal", { bg = "none" })
			vim.api.nvim_set_hl(0, "SnacksNormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "SnacksWinBar", { bg = "none" })
			vim.api.nvim_set_hl(0, "SnacksBackdrop", { bg = "none" })
		end,
	},
}
