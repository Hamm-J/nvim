return {
	"nvim-telescope/telescope.nvim",
	lazy = true,
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	config = function()
		local is_actions, actions = pcall(require, "telescope.actions")
		if not is_actions then
			return
		end

		local force_delete_buffer = function(prompt_bufnr)
			local action_state = require("telescope.actions.state")
			local current_picker = action_state.get_current_picker(prompt_bufnr)
			current_picker:delete_selection(function(selection)
				local bufnr = selection.bufnr
				vim.api.nvim_buf_delete(bufnr, { force = true })
			end)
		end

		require("telescope").setup({
			defaults = {
				initial_mode = "normal",
				fname_width = 90,
                layout_strategy = "vertical",
				layout_config = {
					width = { padding = 0 },
					height = { padding = 0 },
					vertical = {
						preview_cutoff = 0,
					},
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<c-q>"] = force_delete_buffer,
					},
					n = {
						["<c-q>"] = force_delete_buffer,
						["<S-j>"] = actions.cycle_history_next,
						["<S-k>"] = actions.cycle_history_prev,
					},
				},
				borderchars = { "", "", "", "", "", "", "", "" },
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")

		local function keybind_picker_window_toggles(mappings)
			local settings_compact = {
				previewer = false,
				layout_config = {
					width = 0.3,
					height = 0.3,
				},
			}

			local settings_fullscreen = {
				layout_config = {},
			}
			for _, m in ipairs(mappings) do
				vim.keymap.set("n", m[1], function()
					m[3](settings_compact)
				end)
				vim.keymap.set("n", m[2], function()
					m[3](settings_fullscreen)
				end)
			end
		end
		local function merge(...)
			local result = {}
			for _, t in ipairs({ ... }) do
				for k, v in pairs(t) do
					result[k] = v
				end
			end
			return result
		end

		keybind_picker_window_toggles({
			{
				"<leader>k",
				"<leader><leader>k",
				builtin.keymaps,
			},
			{
				"<C-n>",
				"<C-S-n>",
				builtin.buffers,
			},
			{
				"<leader>sg",
				"<leader><leader>sg",
				builtin.live_grep,
			},
			{
				"<leader>j",
				"<leader><leader>j",
				builtin.jumplist,
			},
			{
				"<leader>m",
				"<leader><leader>m",
				builtin.marks,
			},
			{
				"<leader>da",
				"<leader><leader>da",
				builtin.diagnostics,
			},
			{
				"<leader>ds",
				"<leader><leader>ds",
				builtin.lsp_document_symbols,
			},
			{
				"<C-p>",
				"<C-S-p>",
				function(settings)
					builtin.find_files(merge(settings, {
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"-g",
							"!.git",
						},
					}))
				end,
			},
			{
				"g/",
				"g//",
				function(settings)
					require("telescope.builtin").current_buffer_fuzzy_find(merge(settings, {
						bufnr = vim.api.nvim_get_current_buf(),
						default_text = vim.fn.expand("<cword>"),
					}))
				end,
			},
			{
				"<leader>/",
				"<leader><leader>/",
				function(settings)
					require("telescope.builtin").current_buffer_fuzzy_find(merge(settings, {
						bufnr = vim.api.nvim_get_current_buf(),
					}))
				end,
			},
			{
				"<leader>td",
				"<leader><leader>td",
				function(settings)
					local width = settings.layout_config and settings.layout_config.width
					local height = settings.layout_config and settings.layout_config.height

					vim.cmd(string.format("TodoTelescope layout_config={width=%s,height=%s}", width, height))
				end,
			},
		})
	end,
}
