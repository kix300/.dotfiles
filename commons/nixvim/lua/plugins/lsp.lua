return {
	servers = {
		qmlls = {
			cmd = { "qmlls" },
			filetypes = { "qml", "qmljs" },

			root_dir = function(fname)
				return require("lspconfig.util").root_pattern(
					"*.qml", "qmldir", "CMakeLists.txt", "Makefile",
					"package.json", ".git", ".qmlproject"
				)(fname) or vim.fn.getcwd()
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
	}
}
