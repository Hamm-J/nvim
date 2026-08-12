return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- { "mason-org/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		-- "mason-org/mason-lspconfig.nvim",
		{ "mason-org/mason.nvim", version = "1.11.0" },
		{ "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{
			"j-hui/fidget.nvim",
			opts = {
				notification = {
					window = {
						-- makes the notification window background transparent
						winblend = 0,
					},
				},
			},
		},

		-- Allows extra capabilities provided by nvim-cmp
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		-- "hrsh7th/cmp-nvim-lua",
	},
	config = function()
		--  This function gets run when an LSP attaches to a particular buffer.
		--    That is to say, every time a new file is opened that is associated with
		--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
		--    function will be executed to configure the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				-- map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				-- map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				map("<leader>vd", vim.diagnostic.open_float, "[V]iew [D]iagnostic")

				map("[d", vim.diagnostic.goto_prev, "Previous [D]iagnostic")

				map("]d", vim.diagnostic.goto_next, "Next [D]iagnostic")

				map("<leader>q", vim.diagnostic.setloclist, "View All Diagnostics")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				-- The following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		local mason_packages_dir = vim.fn.stdpath("data") .. "/mason/packages/"

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			gopls = {},
			astro = {
				init_options = {
					typescript = {
						tsdk = vim.fs.normalize(
							vim.fn.stdpath("data")
								.. "/mason/packages/astro-language-server/node_modules/typescript/lib"
						),
					},
				},
			},
			templ = {},
			intelephense = {},
			bashls = {},
			-- phpactor = {},

			elixirls = {
				cmd = { mason_packages_dir .. "elixir-ls/language_server.sh" },
			},
			ts_ls = {
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = mason_packages_dir
								.. "vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
							languages = { "vue" },
						},
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				settings = {
					implicitProjectConfiguration = {
						checkJs = true,
						strict = true,
						lib = { "es2022", "dom" },
					},
				},
			},
			volar = {},

            ty =  {
                  cmd = { "ty", "server" },
                  filetypes = { "python" },
                  root_dir = vim.fs.root(0, { ".git/", "pyproject.toml" }),
                  single_file_support = true,
            },

			-- basedpyright = {
			-- 	settings = {
			-- 		basedpyright = {
			-- 			analysis = {
			-- 				useLibraryCodeForTypes = true,
			-- 				-- typeCheckingMode = "basic",
			-- 				typeCheckingMode = "recommended",
			-- 				diagnosticMode = "workspace",
			-- 				autoSearchPath = true,
			-- 				-- inlayHints = {
			-- 				--       reportUnusedCallResult = false,
			-- 				-- },
			-- 				diagnosticSeverityOverrides = {
			-- 					reportUnannotatedClassAttribute = false,
			-- 					reportAny = false,
			-- 					reportExplicitAny = false,
			-- 					-- reportMissingTypeArgument = false,
			-- 					-- reportMissingTypeStubs = false,
			-- 					-- reportUnknownArgumentType = false,
			-- 					reportUnknownMemberType = false,
			-- 					-- reportUnknownParameterType = false,
			-- 					reportUnknownVariableType = false,
			-- 					reportUnusedCallResult = false,
			-- 					reportCallInDefaultInitializer = false,
			-- 					-- reportUnusedParameter = false,
   --                              reportUninitializedInstanceVariable = false,
			-- 				},
			-- 				extraPaths = {
			-- 					"./venv",
			-- 					"./.venv",
			-- 				},
			-- 			},
			-- 			python = {
			-- 				venvPath = ".",
			-- 				venv = "venv",
			-- 			},
			-- 		},
			-- 	},
			-- },

			-- tailwindcss = {
			-- 	filetypes = {
			-- 		"javascript",
			-- 		"typescript",
			-- 		"html",
			-- 		"react",
			-- 		"vue",
			-- 		"css",
			-- 		"templ",
			-- 		"jsx",
			-- 		"tsx",
			-- 		-- "heex"
			-- 	},
			-- 	init_options = {
			-- 		userLanguages = {
			-- 			templ = "html",
			-- 		},
			-- 	},
			-- },

			sqlls = {
				autostart = false,
			},
			-- htmx = {},

			lua_ls = {
				-- cmd = {...},
				-- filetypes = { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
		}

		require("mason").setup()

		-- You can add other tools here that you want Mason to install
		-- for you, so that they are available from within Neovim.
		-- local ensure_installed = vim.tbl_keys(servers or {})
		-- vim.list_extend(ensure_installed, {
		-- 	"stylua", -- Used to format Lua code
		-- })
        local ensure_installed = {}
		for server_name, _ in pairs(servers) do
			if server_name ~= "ty" then
				table.insert(ensure_installed, server_name)
			end
		end
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for tsserver)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					vim.lsp.config(server_name, server)
					vim.lsp.enable(server_name)
				end,
			},
		})

        -- Manually configure and enable 'ty' (installed on your system PATH)
		local ty_config = servers["ty"]
		if ty_config then
			ty_config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, ty_config.capabilities or {})
			
			-- Merge with your overrides or use the defaults
			vim.lsp.config("ty", ty_config)
			vim.lsp.enable("ty")
		end

		local diagnosticSigns = {
			-- Error = "󰅚 ",
			-- Warn = "󰀪 ",
			-- Hint = "󰌶 ",
			-- Info = " ",
			Error = "!",
			Warn = "?",
			Hint = "-",
			Info = "-",
		}
		for type, icon in pairs(diagnosticSigns) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, {
				text = icon,
				texthl = hl,
				numhl = hl,
			})
		end

		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})
	end,
}
