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
		-- Two important keymaps to use while in Telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- Telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!
		--
		local actions_setup, actions = pcall(require, "telescope.actions")
		if not actions_setup then
			return
		end

		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					width = { padding = 0 },
					height = { padding = 0 },
					-- height = 0.95,
					-- width = 0.95,
					vertical = {
						preview_cutoff = 0,
					},
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<c-q>"] = actions.delete_buffer,
					},
					n = {
						["<C-q>"] = actions.delete_buffer,
						["<S-j>"] = actions.cycle_history_next,
						["<S-k>"] = actions.cycle_history_prev,
					},
				},
				borderchars = { "", "", "", "", "", "", "", "" },
			},
			pickers = {
				find_files = {
					initial_mode = "normal",
					-- hidden = true,
					-- show dotfiles besides .git folder
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"-g",
						"!.git",
					},
				},
				resume = {
					initial_mode = "normal",
					fname_width = 90,
				},
				live_grep = {
					initial_mode = "normal",
					fname_width = 90,
				},
				grep_string = {
					initial_mode = "normal",
					fname_width = 90,
				},
				buffers = {
					initial_mode = "normal",
					fname_width = 90,
				},
				current_buffer_fuzzy_find = {
					initial_mode = "normal",
					fname_width = 90,
				},
				help_tags = {
					initial_mode = "normal",
					fname_width = 90,
				},
				diagnostics = {
					initial_mode = "normal",
					fname_width = 90,
				},
				jumplist = {
					initial_mode = "normal",
					fname_width = 90,
				},
                lsp_incoming_calls = {
					initial_mode = "normal",
					fname_width = 90,
                },
                lsp_outgoing_calls = {
					initial_mode = "normal",
					fname_width = 90,
                },
				keymaps = {
					initial_mode = "normal",
					fname_width = 90,
				},
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
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<c-p>", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set("n", "<leader>j", builtin.jumplist, { desc = "[J]umplist" })
		vim.keymap.set("n", "<leader>li", builtin.lsp_incoming_calls, { desc = "[L]SP [I]ncoming Calls" })
		vim.keymap.set("n", "<leader>lo", builtin.lsp_outgoing_calls, { desc = "[L]SP [O]utgoing Calls" })
		vim.keymap.set("n", "<leader>k", builtin.keymaps, { desc = "[K]eymaps" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
