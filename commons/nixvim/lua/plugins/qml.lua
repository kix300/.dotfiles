return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {
          cmd = { "qmlls" },
          filetypes = { "qml" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("*.qml")(fname)
          end,
          settings = {
            qml = {
              lint = {
                unusedImports = true,
                compatibleTypes = true,
              }
            }
          }
        },
      },
    },
  }
}
