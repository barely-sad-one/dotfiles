return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        'nvim-treesitter/playground',
    },
    build = ":TSUpdate",
    config = function()
        -- Custom filetype association
        vim.filetype.add({
            extension = {
                c3 = "c3",
                c3i = "c3",
                c3t = "c3",
            },
        })

        -- Add custom parser for c3
        -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        -- parser_config.c3 = {
        --     install_info = {
        --         url = "https://github.com/c3lang/tree-sitter-c3",
        --         files = { "src/parser.c", "src/scanner.c" },
        --         branch = "main",
        --     },
        -- }

        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua", "python", "javascript", "typescript", "html", "css", "nu",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            playground = {
                enable = true,
            },
        })

        -- Add custom parser for c3
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.c3 = {
            install_info = {
                url = "https://github.com/c3lang/tree-sitter-c3",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "main",
            },
        }
    end,
}







-- return {
--     "nvim-treesitter/nvim-treesitter",
--     dependencies = {
--         'nvim-treesitter/playground',
--     },
--     build = ":TSUpdate",
--     config = function()
--         require("nvim-treesitter.configs").setup({
--             playground = {
--                 enable = true,
--             },
--             ensure_installed = {
--                 "lua", "python", "javascript", "typescript", "html", "css", -- Add more languages as needed
--             },
--             highlight = {
--                 enable = true, -- Enable Treesitter-based highlighting
--                 additional_vim_regex_highlighting = false,
--             },
--             indent = {
--                 enable = true, -- Enable Treesitter-based indentation
--             },
--         })
--     end,
-- }
