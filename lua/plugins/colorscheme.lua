return {
    "rose-pine/neovim",
    -- "EdenEast/nightfox.nvim",
    -- "catppuccin/nvim",
    -- "EdenEast/nightfox.nvim",
    -- "loctvl842/monokai-pro.nvim",
    -- "folke/tokyonight.nvim",
    -- "akinsho/horizon.nvim",
    -- "Mofiqul/dracula.nvim",
    -- "ribru17/bamboo.nvim",

    -- "zenbones-theme/zenbones.nvim",
    -- dependencies = "rktjmp/lush.nvim",

    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
        vim.cmd.colorscheme("rose-pine")
        -- vim.cmd.colorscheme("nightfox")
        -- vim.cmd.colorscheme("carbonfox")
        -- vim.cmd.colorscheme("terafox")
        -- vim.cmd.colorscheme("horizon")
        -- vim.cmd.colorscheme("monokai-spectrum")
        -- vim.cmd.colorscheme("tokyonight-storm")
        -- vim.cmd.colorscheme("tokyonight-moon")
        -- vim.cmd.colorscheme("tokyonight-night")
        -- vim.cmd.colorscheme("dracula")
        -- vim.cmd.colorscheme("catppuccin")
        -- vim.cmd.colorscheme("zenbones")
        -- vim.cmd.colorscheme("rosebones")
        -- vim.cmd.colorscheme("zenburned")
        -- vim.cmd.colorscheme("kanagawabones")

        -- You can configure highlights by doing something like:
        vim.cmd.hi("Comment gui=none")
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
    -- config = function()
    --     require("bamboo").setup({
    --           toggle_style_list = { 'multiplex' }, -- List of styles to toggle between
    --     })
    --     require("bamboo").load()
    --     -- require("monokai-pro").setup({
    --     --   filter = "octagon", -- classic | octagon | pro | machine | ristretto | spectrum
    --     -- })
    --     --
    --     -- require("catppuccin").setup({
    --     --     flavour = "mocha",
    --     --     background = {
    --     --         dark = "mocha"
    --     --     }
    --     -- })
    -- end
}
