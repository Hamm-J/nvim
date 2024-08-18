-- return { -- Autoformat
-- 	"stevearc/conform.nvim",
-- 	event = { "BufWritePre" },
-- 	cmd = { "ConformInfo" },
-- 	keys = {
-- 		{
-- 			"<leader>f",
-- 			function()
-- 				require("conform").format({ async = true, lsp_fallback = true })
-- 			end,
-- 			mode = "",
-- 			desc = "[F]ormat buffer",
-- 		},
-- 	},
-- 	opts = {
-- 		notify_on_error = false,
-- 		-- format_on_save = function(bufnr)
-- 		-- 	-- Disable "format_on_save lsp_fallback" for languages that don't
-- 		-- 	-- have a well standardized coding style. You can add additional
-- 		-- 	-- languages here or re-enable it for the disabled ones.
-- 		-- 	local disable_filetypes = { c = true, cpp = true }
-- 		-- 	return {
-- 		-- 		timeout_ms = 500,
-- 		-- 		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
-- 		-- 	}
-- 		-- end,
-- 		formatters_by_ft = {
-- 			lua = { "stylua" },
-- 			-- Conform can also run multiple formatters sequentially
-- 			-- python = { "isort", "black" },
-- 			--
-- 			-- You can use 'stop_after_first' to run the first available formatter from the list
-- 			-- javascript = { "prettierd", "prettier", stop_after_first = true },
-- 		},
-- 	},
-- }
return {
	"nvimtools/none-ls.nvim",
    keys = {
		{
			"<leader>ff",
			function()
                vim.lsp.buf.format()
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
    },
	config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        -- local diagnostics = null_ls.builtins.diagnostics
		null_ls.setup({
			sources = {
				formatting.prettier,
				formatting.stylua,
				-- diagnostics.eslint_d,
				formatting.gofumpt,
			},
			-- configure format on save
			-- on_attach = function(current_client, bufnr)
			-- 	if current_client.supports_method("textDocument/formatting") then
			-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			-- 		vim.api.nvim_create_autocmd("BufWritePre", {
			-- 			group = augroup,
			-- 			buffer = bufnr,
			-- 			callback = function()
			-- 				vim.lsp.buf.format({
			-- 					filter = function(client)
			-- 						--  only use null-ls for formatting instead of lsp server
			-- 						return client.name == "null-ls"
			-- 					end,
			-- 					bufnr = bufnr,
			-- 				})
			-- 			end,
			-- 		})
			-- 	end
			-- end,
		})
	end,
}
