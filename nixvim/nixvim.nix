{ config, lib, pkgs, ... }:

{
	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.neovim = {
		defaultEditor = true;
		enable = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		extraPackages = with pkgs; [
			ripgrep
		];

		plugins = with pkgs.vimPlugins; [
			LazyVim
				lazy-nvim
				nvim-treesitter
				snacks-nvim
				telescope-nvim
				neo-tree-nvim
				persistence-nvim
				nvim-ts-autotag
				nvim-lint
				gitsigns-nvim
				todo-comments-nvim
				nvim-lspconfig
				mini-ai
				lualine-nvim
				which-key-nvim
				mini-pairs
				mason-nvim
				mason-lspconfig-nvim
				bufferline-nvim
				flash-nvim
				marks-nvim
				nvim-treesitter-textobjects
				noice-nvim
				tokyonight-nvim
				catppucin-nvim
				ts-comments-nvim
				];
		extraLuaConfig = ''
			require("lazy").setup({
					spec = {
					{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
					{ import = "plugins" },
					},
					dev = {
					path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
					patterns = {""}, -- Specify that all of our plugins will use the dev dir. Empty string is a wildcard!
					},
					performance = {
					-- Used for NixOS
					reset_packpath = false,
					rtp = {
					reset = false,
					disabled_plugins = {
					"gzip",
					-- "matchit",
					-- "matchparen",
					-- "netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
					},
					}
					},
					defaults = {
						lazy = true,
						version = false, -- always use the latest git commit
							-- version = "*", -- try installing the latest stable version for plugins that support semver
					},
					install = {
						-- Safeguard in case we forget to install a plugin with Nix
							missing = false,
					},
			})
		'';
	};

	xdg.configFile."nvim/lua" = {
		recursive = true;
		source = ./lua;
	};
}
