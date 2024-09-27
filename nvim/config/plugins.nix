{
	plugins = {
		lualine.enable = true;
		lsp = {
			enable = true;
			servers = {
				clangd.enable = true;
				cmake.enable = true;
				vuels.enable = true;
			};
		};
		treesitter.enable = true;
		persistence.enable = true;
		lazy.enable = true;
		hardtime.enable = true;
		oil.enable = true;
		luasnip.enable = true;
		bufferline.enable = true;
		web-devicons.enable = true;
	};
	plugins.telescope = {
		enable = true;
		keymaps = {
			"<space><space>" = {
				options.desc = "Find Files (root dir)";
				action = "find_files";
			};
		};
	};
	plugins.cmp = {
		enable = true;
		autoEnableSources = true;
		settings = {
			sources = [
			{name = "nvim_lsp";}
			{name = "path";}
			{name = "buffer";}
			{name = "luasnip";}
			];
			snippet.expand = "luasnip";
			mappingPresets = ["insert" "cmdline"];
			mapping = {
				"<C-n>" = ''cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })'';
				"<C-p>" = ''cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })'';
				"<C-b>" = ''cmp.mapping.scroll_docs(-4)'';
				"<C-f>" = ''cmp.mapping.scroll_docs(4)'';
				"<C-Space>" = ''cmp.mapping.complete()'';
				"<C-e>" = ''cmp.mapping.abort()'';
				"<CR>" = ''cmp.mapping.confirm({ select = true })''; 
				"<S-CR>" = ''cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, })''; 
				"<C-CR>" = ''function(fallback) cmp.abort() fallback() end'';
			};
		};
	};
}
