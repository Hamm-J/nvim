return {
	"nvim-lualine/lualine.nvim",
	opts = {},
	config = function()
		require("lualine").setup({
			options = {
				-- theme = lualine_horizon,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				-- disable lualine for dapui windows
				disabled_filetypes = {
					"dapui_watches",
					"dapui_breakpoints",
					"dapui_scopes",
					"dapui_console",
					"dapui_stacks",
					"dap-repl",
				},
			},
			sections = {
				lualine_a = {
					{
						"filename",
						cond = function()
							-- return vim.bo.filetype ~= "oil" and vim.fn.bufname("") ~= ""
							return vim.bo.filetype ~= "oil"
						end,
					},
					{
						function()
							return require("oil").get_current_dir()
						end,
						cond = function()
							return vim.bo.filetype == "oil"
						end,
					},
					-- {
					-- 	function()
					-- 		return vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
					-- 	end,
					-- 	cond = function()
					-- 		return vim.fn.bufname("") == ""
					-- 	end,
					-- },
				},
				lualine_b = {
					-- "branch",
					-- "diff",
					-- "diagnostics",
				},
				-- lualine_a = { "mode" },
				-- lualine_b = {
				-- 	"branch",
				-- 	"diff",
				-- 	"diagnostics",
				-- },
				lualine_c = {
					--"filename",
					-- {
					--     function()
					--         return require("oil").get_current_dir()
					--     end,
					--     cond = function()
					--         return vim.bo.filetype == "oil"
					--     end,
					-- },
				},
				-- lualine_x = { "progress" },
				-- lualine_y = { "location" },
				lualine_x = {
					-- "diagnostics"
				},
				lualine_y = {
					-- "diff"
					-- "location"
					-- "searchcount",
					-- "selectioncount",
				},
				lualine_z = {
					"progress",
					-- "filename",
					-- "buffers"
					-- "filetype",
					-- "fileformat",
					-- "encoding",
				},
			},
			tabline = {
				lualine_a = {
					-- "branch"
					-- {
					--     function()
					--         return require("oil").get_current_dir()
					--     end,
					--     cond = function()
					--         return vim.bo.filetype == "oil"
					--     end,
					-- },
					{
						"buffers",
						symbols = {
							-- alternate_file = "",
							modified = " +",
						},
					},
				},
				-- 	lualine_a = { "filename" },
				-- 	lualine_b = {},
				-- 	lualine_c = {},
				-- 	lualine_x = {},
				-- 	lualine_y = { "" },
				lualine_z = { "tabs" },
				-- 	lualine_z = {},
			},
		})
	end,
}
