return {
	-- "rose-pine/neovim",
    "EdenEast/nightfox.nvim",
	-- priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		-- vim.cmd.colorscheme("rose-pine")
		-- vim.cmd.colorscheme("nightfox")
		-- vim.cmd.colorscheme("carbonfox")
        vim.cmd.colorscheme("terafox")

		-- You can configure highlights by doing something like:
		vim.cmd.hi("Comment gui=none")
	end,
}
