return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            numhl = false, -- color line number with git status
        })
    end,
}
