return
{
  "keremimo/noctalia.nvim",
  main = "noctalia",
  lazy = false,
  priority = 10000,
  opts = {
    palette_path = vim.fn.expand("~/.local/state/noctalia/garnet-dark.json"),
    transparent = true,
  },
  config = function(_, opts)
    require("noctalia").setup(opts)
    vim.cmd.colorscheme("noctalia")
  end,
}
