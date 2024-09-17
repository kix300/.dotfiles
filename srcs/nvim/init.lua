-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")


local set = vim.opt

local TAB_WIDTH = 4
set.tabstop = TAB_WIDTH
set.shiftwidth = TAB_WIDTH
set.expandtab = false
