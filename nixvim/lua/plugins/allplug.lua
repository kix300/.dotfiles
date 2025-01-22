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

	{ 'echasnovski/mini.base16', enbale = false },

	{ "vague2k/huez.nvim" },

	{ "akinsho/bufferline.nvim" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "stevearc/conform.nvim" },
	{ "glepnir/dashboard-nvim" },
	{ "stevearc/dressing.nvim" },
	{ "folke/flash.nvim" },
	{ "rafamadriz/friendly-snippets" },
	{ "lewis6991/gitsigns.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "nvim-lualine/lualine.nvim" },
	-- { "echasnovski/mini.nvim", enbale = false },
	{ "nvim-neo-tree/neo-tree.nvim" },
	{ "folke/neoconf.nvim" },
	{ "folke/neodev.nvim" },
	{ "folke/noice.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
		},
	},
	{ "mfussenegger/nvim-lint" },
	{ "neovim/nvim-lspconfig" },
	{ "rcarriga/nvim-notify" },
	{ "nvim-pack/nvim-spectre" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "windwp/nvim-ts-autotag" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "folke/persistence.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "nvim-telescope/telescope.nvim" },
	{ "folke/todo-comments.nvim" },
	{ "folke/tokyonight.nvim" },
	{ "folke/trouble.nvim" },
	{ "RRethy/vim-illuminate" },
	{ "dstein64/vim-startuptime" },
	{ "folke/which-key.nvim" },
	{ "ibhagwan/fzf-lua" },
	{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin",
		}
	},
}
