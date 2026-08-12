return {
	"tpope/vim-fugitive",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitiveblame",
			callback = function()
				vim.keymap.set("n", "<leader>ge", function()
					vim.cmd("quit")
					vim.cmd("Gedit")
					vim.cmd("Git blame")
				end, { buffer = true })
			end,
		})
	end,
}
