return {
	"rose-pine/neovim",
    -- "catppuccin/nvim",
    -- "EdenEast/nightfox.nvim",
    -- "loctvl842/monokai-pro.nvim",
    -- "folke/tokyonight.nvim",
    -- "akinsho/horizon.nvim",
    -- "Mofiqul/dracula.nvim",

	-- priority = 1000, -- Make sure to load this before all the other start plugins.
	init = function()
		vim.cmd.colorscheme("rose-pine")
		-- vim.cmd.colorscheme("nightfox")
		-- vim.cmd.colorscheme("carbonfox")
        -- vim.cmd.colorscheme("terafox")
        -- vim.cmd.colorscheme("horizon")
        -- vim.cmd.colorscheme("monokai-spectrum")
        -- vim.cmd.colorscheme("tokyonight-storm")
        -- vim.cmd.colorscheme("dracula")
		-- vim.cmd.colorscheme("catppuccin")
--
		-- You can configure highlights by doing something like:
		vim.cmd.hi("Comment gui=none")
	end,
    -- config = function()
        -- require("monokai-pro").setup({
        --   filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
        -- })
        --
        -- require("catppuccin").setup({
        --     flavour = "mocha",
        --     background = {
        --         dark = "mocha"
        --     }
        -- })
    -- end
}
