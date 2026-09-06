return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        ui = {
            enable = false,
        },
        footer = {
            enabled = false,
        },
        daily_notes = {
            folder = "calendar/daily"
        },
        templates = {
            folder = "template",
        },
        legacy_commands = false, -- this will be removed in 4.0.0
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/notes",
            },
        },
    },
}
