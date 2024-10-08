local opt = vim.opt

-- custom file types
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})
vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})
vim.cmd([[
augroup BladeFiltypeRelated
  au BufNewFile,BufRead *.blade.php set ft=blade
augroup END
]])

-- line numbers
opt.relativenumber = true
opt.number = true
opt.colorcolumn = "80"

-- tabs & indentation
opt.syntax = "on"
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.scrolloff = 8
-- opt.laststatus = 3

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
-- opt.guicursor = "n-v-c-i:block" -- make cursor a block in all modes
opt.showmode = true
--vim.cmd([[ hi BufferTabpageFill guibg=NONE ctermbg=NONE ]])
--vim.cmd([[ hi PmenuSel guibg=#e95678 ctermbg=red ]])

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- word units
opt.iskeyword:append("-")

-- netrw
vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 40
vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"

-- hover menu
-- https://neovim.discourse.group/t/lsp-hover-float-window-too-wide/3276
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "single"
    opts.max_width = opts.max_width or 80
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
