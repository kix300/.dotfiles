{pkgs, ...}:
{
	programs.nixvim = {
		enable = true;
		colorschemes.rose-pine.enable = true;
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
			cmp = {
				enable = true;
				autoEnableSources = true;
				settings.sources = [
					{name = "nvim_lsp";}
					{name = "path";}
					{name = "buffer";}
				];
			};
			treesitter.enable = true;
			persistence.enable = true;
			lazy.enable = true;
			hardtime.enable = true;
			oil.enable = true;
			luasnip.enable = true;
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

		autoCmd = [
		{
			event = [ "BufEnter" "BufWinEnter" ];
			pattern = [ "*.c" "*.h" ];
			command = "echo 'Entering a C or C++ file'";
		}
		];
	};
}
/*
   options = { 
   tabstop = 4;
   shiftwidth = 4;
   expendtab = false;
   number = true;
   relativenumber = true;
   };

 */
