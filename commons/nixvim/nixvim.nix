{ lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    opts.clipboard = "unnamedplus";
    vimAlias = true;
    viAlias = true;
    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      # Telescope
      tree-sitter
      ripgrep
      wl-clipboard
      fzf
    ];

    extraPlugins = with pkgs.vimPlugins; [
      LazyVim
    ];

    extraConfigLua =
      let
        plugins = with pkgs.vimPlugins; [
          # LazyVim
          LazyVim
        ];
        mkEntryFromDrv =
          drv:
          if lib.isDerivation drv then
            {
              name = "${lib.getName drv}";
              path = drv;
            }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        		require("lazy").setup({
        		  defaults = {
        			lazy = true,
        		  },
        		  dev = {
        			-- reuse files from pkgs.vimPlugins.*
        			path = "${lazyPath}/pack/myNeovimPackages/start",
        			patterns = { "" },
        			-- fallback to download
        			fallback = true,
        		  },
        		  spec = {
        			{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
        			-- The following configs are needed for fixing lazyvim on nix
        			-- force enable telescope-fzf-native.nvim
        			{ "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
        			-- disable mason.nvim, use programs.neovim.extraPackages
        			{ "mason-org/mason-lspconfig.nvim", enabled = false },
        			{ "mason-org/mason.nvim", enabled = false },
        			-- disable problematic extras that cause keymap errors
        			{ "lazyvim.plugins.extras.editor.snacks_picker", enabled = false },
        			-- disable default LSP keymaps to avoid conflicts
        			{ "lazyvim.plugins.lsp.keymaps", enabled = false },
        			-- import/override with your plugins
        			{ import = "plugins" },
        			-- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
        			{ "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
        		  },
        		})

        			  vim.g.clipboard = {
        		name = "wl-clipboard (Wayland)",
        		copy = {
        		  ["+"] = "${pkgs.wl-clipboard}/bin/wl-copy --foreground --type text/plain",
        		  ["*"] = "${pkgs.wl-clipboard}/bin/wl-copy --foreground --primary --type text/plain",
        		},
        		paste = {
        		  ["+"] = "${pkgs.wl-clipboard}/bin/wl-paste --no-newline",
        		  ["*"] = "${pkgs.wl-clipboard}/bin/wl-paste --no-newline --primary",
        		},
        		cache_enabled = true,
        	  }
        			'';
  };

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
}
