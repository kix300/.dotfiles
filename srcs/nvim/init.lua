-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")


local set = vim.opt

local TAB_WIDTH = 4
set.tabstop = TAB_WIDTH
set.shiftwidth = TAB_WIDTH
set.expandtab = false
--vim.cmd [[colorscheme tokyonight-moon]]
--vim.o.background = "light"
--vim.cmd ([[colorscheme gruvbox]])
--vim.cmd('colorscheme base16-tokyo-city-terminal-dark')
vim.cmd.colorscheme "catppuccin-mocha"
