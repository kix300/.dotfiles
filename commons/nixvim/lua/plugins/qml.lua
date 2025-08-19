return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        qmlls = {
          cmd = { "qmlls" }, -- ou "qmlls6" selon votre installation
          filetypes = { "qml" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "*.qml", "qmldir", "CMakeLists.txt", "Makefile"
            )(fname)
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
  },
  
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "qmljs" }, -- Note: c'est "qmljs" pour Tree-sitter
    },
  },
}
