local opt = vim.opt

-- custom file types
vim.filetype.add({
	extension = {
		templ = "templ",
	},
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

-- line numbers
opt.relativenumber = true
opt.number = true
opt.colorcolumn = "80"

-- tabs & indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.scrolloff = 8
-- opt.laststatus = 3
vim.o.timeout = true
vim.o.timeoutlen = 250
-- vim.o.ttimeoutlen = 10  -- Reduces the wait time for key codes

-- completion
-- popup: docs for the selected item; fuzzy: 0.12 fuzzy matching;
-- noinsert: nothing is inserted until you pick with <C-y>.
opt.completeopt = "menu,menuone,popup,fuzzy,noinsert"

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
-- opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
-- opt.guicursor = "n-v-c-i:block" -- make cursor a block in all modes
opt.showmode = true
--vim.cmd([[ hi BufferTabpageFill guibg=NONE ctermbg=NONE ]])
--vim.cmd([[ hi PmenuSel guibg=#e95678 ctermbg=red ]])
--
--
vim.cmd([[ highlight ColorColumn guibg=#1A1C23 ]])

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- word units
opt.iskeyword:append("-")
