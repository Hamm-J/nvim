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
    config = function()
        require("rose-pine").setup({
            variant = "auto", -- auto, main, moon, or dawn
            dark_variant = "main", -- main, moon, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            enable = {
                terminal = true,
                legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                migrations = true, -- Handle deprecated options automatically
            },

            styles = {
                bold = true,
                italic = true,
                transparency = true,
            },

            groups = {
                border = "muted",
                link = "iris",
                panel = "surface",

                error = "love",
                hint = "iris",
                info = "foam",
                note = "pine",
                todo = "rose",
                warn = "gold",

                git_add = "foam",
                git_change = "rose",
                git_delete = "love",
                git_dirty = "rose",
                git_ignore = "muted",
                git_merge = "iris",
                git_rename = "pine",
                git_stage = "iris",
                git_text = "rose",
                git_untracked = "subtle",

                h1 = "iris",
                h2 = "foam",
                h3 = "rose",
                h4 = "gold",
                h5 = "pine",
                h6 = "foam",
            },

            palette = {
                -- Override the builtin palette per variant
                -- moon = {
                --     base = '#18191a',
                --     overlay = '#363738',
                -- },
            },

            -- NOTE: Highlight groups are extended (merged) by default. Disable this
            -- per group via `inherit = false`
            highlight_groups = {
                -- Comment = { fg = "foam" },
                -- StatusLine = { fg = "love", bg = "love", blend = 15 },
                -- VertSplit = { fg = "muted", bg = "muted" },
                -- Visual = { fg = "base", bg = "text", inherit = false },
            },

            before_highlight = function(group, highlight, palette)
                -- Disable all undercurls
                -- if highlight.undercurl then
                --     highlight.undercurl = false
                -- end
                --
                -- Change palette colour
                -- if highlight.fg == palette.pine then
                --     highlight.fg = palette.foam
                -- end
            end,
        })
    end
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
