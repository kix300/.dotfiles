return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configure LSP servers with proper keymap setup
        ['*'] = {
          keys = {
            { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition", has = "definition" },
            { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to references", has = "references" },
            { "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to implementation", has = "implementation" },
            { "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Go to type definition", has = "typeDefinition" },
            { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to declaration", has = "declaration" },
            { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover", has = "hover" },
            { "gK", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature help", has = "signatureHelp" },
            { "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", mode = "i", desc = "Signature help", has = "signatureHelp" },
            { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action", has = "codeAction", mode = { "n", "v" } },
            { "<leader>cc", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action", has = "codeAction", mode = { "n", "v" } },
            { "<leader>cf", "<cmd>lua require('conform').format()<CR>", desc = "Format document", has = "documentFormatting" },
            { "<leader>cf", "<cmd>lua require('conform').format()<CR>", desc = "Format range", mode = "v", has = "documentRangeFormatting" },
            { "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename", has = "rename" },
          },
        },
        -- Specific server configurations
        qmlls = {
          cmd = { "qmlls" },
          filetypes = { "qml" },
          root_dir = function(fname)
            return require("lspconfig.util").find_git_ancestor(fname) or vim.fn.getcwd()
          end,
          settings = {},
        },
      },
    },
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")

    -- Setup QML LSP specifically
    lspconfig.qmlls.setup({
      cmd = { "qmlls" },
      filetypes = { "qml" },
      root_dir = lspconfig.util.find_git_ancestor,
      settings = {},
    })

    -- Enable QML LSP
    vim.lsp.enable("qmlls")
  end,
}
