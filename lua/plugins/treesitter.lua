return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        -- ensure_installed = {},
        auto_install = false,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
        require 'nvim-treesitter.configs'.setup {
            indent = {
                enable = true
            }
        }
        -- FIXME: finish setting up blade TS support
        -- I think I might need to manually do some treesitter injections
        -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        -- parser_config.blade = {
        -- 	install_info = {
        -- 		url = "https://github.com/EmranMR/tree-sitter-blade",
        -- 		files = { "src/parser.c" },
        -- 		branch = "main",
        -- 	},
        -- 	filetype = "blade",
        -- }
        --
        -- vim.filetype.add({
        -- 	pattern = {
        -- 		[".*%.blade%.php"] = "blade",
        -- 	},
        -- })
    end,
}
