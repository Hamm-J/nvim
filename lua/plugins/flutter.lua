return {
	"nvim-flutter/flutter-tools.nvim",
	ft = { "dart" },
	cmd = { "FlutterRun", "FlutterDevices", "FlutterEmulators" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("flutter-tools").setup({
			flutter_lookup_cmd = "mise where flutter",

			widget_guides = { enabled = true },
			closing_tags = { enabled = true, highlight = "Comment", prefix = "// " },

			dev_log = {
				enabled = true,
				open_cmd = "15split",
			},

			lsp = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
					renameFilesWithClasses = "prompt",
					enableSnippets = true,
					updateImportsOnRename = true,
					lineLength = 100,
				},
			},
		})
	end,
}
