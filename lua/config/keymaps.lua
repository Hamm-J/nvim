vim.g.mapleader = " "

local keymap = vim.keymap

-- *** typing ***
keymap.set("i", "<S-tab>", "<C-d>")

-- *** find and replace ***
keymap.set("n", "<leader>rwu", "#``cgN")
keymap.set("n", "<leader>rwd", "*``cgn")

-- *** buffers ***
-- save
keymap.set("n", "<leader>w", "<cmd>write<CR>")
keymap.set("n", "<leader>cc", "<cmd>close<CR>")
keymap.set("n", "<leader>x", "<cmd>x<CR>")
keymap.set("n", "<leader>qq", "<cmd>q<CR>")
keymap.set("n", "<leader>qa", "<cmd>qa<CR>")
keymap.set("n", "<leader>!", "<cmd>qa!<CR>")
-- source
keymap.set("n", "<leader>o", ":source ~/.config/nvim/init.lua<CR>")
-- close buffers/splits
keymap.set("n", "<leader>cb", ":bd<CR>")
keymap.set("n", "<c-Q>", ":bd<CR>")
-- keymap.set("n", "<leader>x", ":bd<CR>")
-- keymap.set("n", "<leader>cs", ":close<CR>")
-- keymap.set("n", "<leader>csb", ":bp<bar>sp<bar>bn<bar>bd<CR>") -- close split buffer, but not split
-- keymap.set("n", "<space><c-q>", ":bp<bar>sp<bar>bn<bar>bd<CR>") -- close split buffer, but not split
keymap.set("n", "<c-q>", ":bp<bar>sp<bar>bn<bar>bd<CR>") -- close split buffer, but not split
keymap.set("n", "<leader>co", ":%bd|e#<CR>")

-- tabs
keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>")
keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>")
-- keymap.set("n", "tn", ":tabnew<CR>")
-- keymap.set("n", "tc", ":tabclose<CR>")

-- navigate splits
-- switch splits
keymap.set("n", "<c-k>", "<cmd>wincmd k<CR>")
keymap.set("n", "<c-j>", "<cmd>wincmd j<CR>")
keymap.set("n", "<c-h>", "<cmd>wincmd h<CR>")
keymap.set("n", "<c-l>", "<cmd>wincmd l<CR>")
-- resize splits
keymap.set("n", "<M-+>", "5<c-W>+") -- increase height
keymap.set("n", "<M-_>", "5<c-W>-") -- decrease height
keymap.set("n", "<M->>", "5<c-W>>") -- increase width
keymap.set("n", "<M-<>", "5<c-W><") -- decrease width

-- navigate buffers
-- requires terminal configuration
-- source: https://www.reddit.com/r/neovim/comments/uc6q8h/ability_to_map_ctrl_tab_and_more/
keymap.set("n", "<C-Tab>", "<cmd>bnext<CR>")
keymap.set("n", "<C-S-Tab>", "<cmd>bprevious<CR>")
keymap.set("n", "<A-Tab>", "<cmd>b#<CR>")
keymap.set("n", "gb", "<cmd>bnext<CR>")
keymap.set("n", "gB", "<cmd>bprevious<CR>")
-- keymap.set("n", "g#b", "<cmd>b#<cr>")
keymap.set("n", "g<S-b>", "<cmd>b#<cr>")
-- keymap.set("n", "<C-Tab>", ":bnext<CR>")
-- keymap.set("n", "<C-S-Tab>", ":bprevious<CR>")
keymap.set("n", "<leader>sn", "<C-w>T")
keymap.set("n", "<leader>bf", ":buffers<CR>")

--- *** plugin zenmode ***
keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>")

-- *** file explorer ***
-- keymap.set("n", "<c-b>", ":Explore<CR>")
-- keymap.set("n", "<c-b>", ":Lex!<CR>")
-- keymap.set("n", "<c-b>", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "<C-b>", function()
  if vim.bo.filetype == "oil" then
    require("oil").close()
  else
    require("oil").open()
  end
end)

-- *** jumplist ***
-- keymap.set("n", "<leader>j", ":jumps<CR>")
-- keymap.set("n", "<leader>j", ":Telescope jumplist<CR>")
keymap.set("n", "<leader>cj", ":clearjumps<CR>")

-- *** fuzzy search ***
-- plugin: telescope
-- keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
-- keymap.set("n", "<leader><C-p>", "<cmd>Telescope resume<cr>")
-- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
-- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
-- keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
-- keymap.set("n", "<c-n>", "<cmd>Telescope buffers<cr>")
-- keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
-- keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
-- keymap.set("n", "<leader>da", "<cmd>Telescope diagnostics<cr>")
-- keymap.set("n", "<leader>td", "<cmd>TodoTelescope<cr>")

-- *** clipboard ***
keymap.set("n", "x", '"_x') -- prevent x from filling up yank buffer
keymap.set("n", "X", '"_x') -- prevent X from filling up yank buffer
-- keymap.set("n", "D", '"_x') -- prevent X from filling up yank buffer

-- *** debugger ***
-- plugin: nvim-dap
keymap.set("n", "<F1>", ":lua require'dap'.terminate()<CR>")
keymap.set("n", "<F8>", ":lua require'dap'.continue()<CR>")
keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>")
keymap.set("n", "<c-F11>", ":lua require'dap'.step_out()<CR>")
keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
keymap.set("n", "<leader>bc", ":lua require'dap'.clear_breakpoints()<CR>")
keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.n.input('Breakpoint condition: '))<CR>")
keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
-- keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")

-- plugin: nvim-dap-ui
keymap.set("n", "<leader>db", ':lua require("dapui").toggle()<CR>')
keymap.set("n", "<leader>de", ':lua require("dapui").eval()<CR>')
keymap.set("n", "<leader>dh", ':lua require("dapui").float_element(nil, { enter = true })<CR>')
keymap.set("n", "<leader>ds", ':lua require("dapui").float_element("scopes", { enter = true })<CR><CR>')
keymap.set("n", "<leader>dr", ':lua require("dapui").float_element("repl", { enter = true })<CR><CR>')
keymap.set("n", "<leader>dc", ':lua require("dapui").float_element("stacks", { enter = true })<CR><CR>')
-- keymap.set("n", "<leader>dhb", ':lua require("dapui").float_element("breakpoints", { width = 80, enter = true })<CR>')
-- keymap.set("n", "<leader>dhw", ':lua require("dapui").float_element("watches", { width = 80, enter = true })<CR>')
-- keymap.set("n", "<leader>dhc", ':lua require("dapui").float_element("console", { width = 80, enter = true })<CR>')

-- *** lsp ***
-- keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
keymap.set("n", "<leader>lr", ":LspRestart<CR>")
-- keymap.set("n", "<leader>li", ":LspInfo<CR>")

-- *** git ***
-- plugin: gitsigns
keymap.set("n", "[g", "<cmd>Gitsigns prev_hunk<CR>")
keymap.set("n", "]g", "<cmd>Gitsigns next_hunk<CR>")

-- plugin: vim-fugitive
keymap.set("n", "<leader>gs", ":Git status<cr>")
keymap.set("n", "<leader>ga", ":Git add .<cr>")
keymap.set("n", "<leader>gc", ":Git commit<cr>")
keymap.set("n", "<leader>gca", ":Git commit --amend<cr>")
keymap.set("n", "<leader>gd", ":Git diff<cr>")
keymap.set("n", "<leader>gvd", ":Gvdiff<cr>")
keymap.set("n", "<leader>gdh", ":Git diff HEAD~1<cr>")
keymap.set("n", "<leader>gds", ":Git diff --staged<cr>")
keymap.set("n", "<leader>gl", ":Git log<cr>")
keymap.set("n", "<leader>gb", ":Git blame<cr>")

-- *** plugin: undotree ***
keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
