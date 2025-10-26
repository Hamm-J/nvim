return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
            width = 80,
            options = {
                signcolumn = "no",
                number = false,
                relativenumber = false,
                cursorline = false,
                cursorcolumn = false,
                foldcolumn = "0",
                list = false,
            },
        },
        plugins = {
            tmux = {
                enabled = false,
            },
        },
    },
}
