return {
    "backdround/tabscope.nvim",
    config = function()
        -- Initialize tabscope
        require("tabscope").setup({})

        -- To remove tab local buffer, use remove_tab_buffer:
        vim.keymap.set("n", "<M-q>", require("tabscope").remove_tab_buffer)
    end,
}
