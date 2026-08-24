
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
		{ "RRethy/base16-nvim", lazy = false, priority = 1000 },
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
vim.api.nvim_create_autocmd('User', {
	pattern = 'LazyDone',
	callback = function()
		local matugen_path = vim.fn.expand('~/.cache/noctalia/matugen.lua')
		if vim.fn.filereadable(matugen_path) == 1 then
			package.loaded['matugen'] = nil
			package.loaded['base16'] = nil
			local ok, matugen = pcall(dofile, matugen_path)
			if ok and matugen and matugen.setup then
				matugen.setup()
				vim.notify('Matugen theme applied!', vim.log.levels.INFO)
			else
				vim.notify('Matugen failed to load', vim.log.levels.WARN)
			end
		end
	end,
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
