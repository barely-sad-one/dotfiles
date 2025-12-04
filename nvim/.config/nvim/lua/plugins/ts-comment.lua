return {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        require('ts-comments').setup()
    end,
}
