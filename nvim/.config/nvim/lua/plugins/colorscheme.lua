local function custom_config()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = false, undercurl = false })
    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {})

    -- vim.api.nvim_set_hl(0, "Comment", { fg = "#D5FF6B", italic = true })
    vim.api.nvim_set_hl(0, "Comment", { fg = "#A3D78A", italic = true })

    -- Set the color for line numbers
    -- vim.cmd [[
    --                 highlight LineNr guifg=#FFFF00
    --                 highlight LineNrAbove guifg=#FFFF00
    --                 highlight LineNrBelow guifg=#FFFF00
    --                 ]]
end

return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  config = function()
    vim.cmd.colorscheme("rose-pine")
    custom_config()
  end
}

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   opts = { style = "moon" },
--   config = function()
--     vim.cmd.colorscheme("tokyonight")
--   end,
-- }
