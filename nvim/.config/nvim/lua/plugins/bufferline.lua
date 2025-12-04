return {
    "akinsho/bufferline.nvim",
    enabled = false,
    config = function()
        require("bufferline").setup {
            options = {
                mode = "buffers",
                numbers = "none",
                path_components = 1,
                diagnostics = false,
                diagnostics_update_in_insert = false,
                persist_buffer_sort = true,
            },
        }
    end,
}
