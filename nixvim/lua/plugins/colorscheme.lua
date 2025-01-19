return {
  { "rebelot/kanagawa.nvim", priority = 1000, event = "VeryLazy" },
  { "Mofiqul/dracula.nvim", priority = 1000, event = "VeryLazy" },
  { "folke/tokyonight.nvim", priority = 1000, event = "VeryLazy" },
  { "Mofiqul/vscode.nvim", priority = 1000, event = "VeryLazy" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    event = "VeryLazy",
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    dependencies = { "vague2k/huez.nvim" },
    opts = {
      news = { lazyvim = false },
      colorscheme = function()
        local colorscheme = require("huez-manager.api.colorscheme").get()
        vim.cmd("colorscheme " .. colorscheme)
      end,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>uC", false },
    },
  },
  {
    "vague2k/huez.nvim",
    branch = "stable",
    event = "UIEnter",
    config = function()
      require("huez").setup({
        fallback = "catppuccin",
      })
    end,
    keys = {
      { "<leader>uC", "<cmd>Huez<CR>", desc = "Colorscheme with Preview" },
    },
  },
}
