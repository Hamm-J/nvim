return {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
        local transparent = require("transparent")

        transparent.setup({
            groups = {
                "Normal",
                "NormalNC",
                "Comment",
                "Constant",
                "Special",
                "Identifier",
                "Statement",
                "PreProc",
                "Type",
                "Underlined",
                "Todo",
                "String",
                "Function",
                "Conditional",
                "Repeat",
                "Operator",
                "Structure",
                "LineNr",
                "NonText",
                "SignColumn",
                "CursorLine",
                "CursorLineNr",
                "StatusLine",
                "StatusLineNC",
                "EndOfBuffer",
            },
            extra_groups = {
                "TelescopeBorder",
                "TelescopeNormal",
                "TelescopePromptNormal",
                "TelescopePromptBorder",
                "TelescopeResultsNormal",
                "TelescopeResultsBorder",
                "TelescopePreviewNormal",
                "TelescopePreviewBorder",
                "NormalFloat",
                "FloatBorder",
                "Pmenu",
                "PmenuSel",
                "ZenBg",
                "ZenBase",
                -- "FidgetTask",
                -- "FidgetTitle",
                -- "FidgetNormal",
            },
            on_clear = function()
                local hl = vim.api.nvim_set_hl

                -- Improved helper function
                local function get_color(group, attr)
                    -- 1. Get the highlight data
                    local data = vim.api.nvim_get_hl(0, { name = group, link = false })
                    local color = data[attr]

                    if not color then
                        return "NONE" -- Fallback if the group doesn't have that attribute
                    end

                    -- 2. Convert Decimal to Hex string (e.g., 16777215 -> "#ffffff")
                    return string.format("#%06x", color)
                end

                -- Extract colors
                local active_fg = get_color("Keyword", "fg")
                local inactive_fg = get_color("Comment", "fg")

                -- 1. Handle Lualine groups
                local groups = vim.fn.getcompletion("lualine_", "highlight")
                for _, group in ipairs(groups) do
                    hl(0, group, { bg = "NONE", ctermbg = "NONE" })

                    if group:match("_a$") or group:match("_active") then
                        hl(0, group, { fg = active_fg, bg = "NONE", bold = true })
                    end
                end

                -- 2. Handle Top Bar (Tabline)
                -- If inactive_fg is still too dark, try "LineNr" instead of "Comment"
                hl(0, "TabLine", { fg = inactive_fg, bg = "NONE" })
                hl(0, "TabLineFill", { bg = "NONE" })
                hl(0, "TabLineSel", { fg = active_fg, bg = "NONE", bold = true })
            end
        })

        -- KEYMAP FOR INSPECTING
        vim.keymap.set("n", "<leader>hi", function()
            local group = vim.fn.synIDattr(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1), "name")
            print("Highlight Group: " .. group)
        end)
    end,
}
