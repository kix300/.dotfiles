return
{
  "keremimo/noctalia.nvim",
  main = "noctalia",
  lazy = false,
  priority = 10000,
  opts = {
    palette_path = vim.fn.expand("~/.local/state/noctalia/community-palettes/Garnet.json"),
    transparent = false,
  },
  config = function(_, opts)
    require("noctalia").setup(opts)
    vim.cmd.colorscheme("noctalia")
  end,
}
