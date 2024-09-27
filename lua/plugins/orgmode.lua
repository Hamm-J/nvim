return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			-- org_agenda_files = '/Users/jason/Documents/orgfiles/*',
			-- org_default_notes_file = '/Users/jason/Documents/orgfiles/refile.org',
			org_agenda_files = "~/Documents/orgfiles/**/*",
			org_default_notes_file = "~/Documents/orgfiles/refile.org",
            mappings = {
                -- unbind to avoid keybind collision with completion prompt
                org_toggle_checkbox = ""
            },
            -- config
            win_split_mode = "vertical",
            calendar_week_start_day = "1",
            -- org_agenda_start_on_weekday = "1",
            -- org_agenda_span = "month",
            org_agenda_span = "week",
            org_deadline_warning_days = 0,
		})

		-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
		-- add ~org~ to ignore_install
		-- require('nvim-treesitter.configs').setup({
		--   ensure_installed = 'all',
		--   ignore_install = { 'org' },
		-- })
		--
		-- update agenda when updating TODO's
		-- https://github.com/nvim-orgmode/orgmode/issues/656#issuecomment-1974891306
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.org",
			callback = function()
				local bufnr = vim.fn.bufnr("orgagenda") or -1
				if bufnr > -1 then
					require("orgmode").agenda:redo()
				end
			end,
		})
	end,
}
