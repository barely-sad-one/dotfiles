-- vim.g.c_syntax_for_h = 1
vim.g.editorconfig = true

vim.filetype.add({
  extension = {
    inl = "c",
  },
})

local set = vim.opt

set.expandtab = true   -- Use spaces instead of tabs
set.shiftwidth = 2     -- Number of spaces for indentation
set.tabstop = 2        -- Number of spaces for a tab
set.softtabstop = 2    -- Number of spaces for a tab while editing

set.relativenumber = true
set.scrolloff      = 7

set.splitbelow     = true
set.splitright     = true

set.mouse		   = 'v'

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sh', 'bash', 'zsh' },
  callback = function()
    vim.bo.omnifunc = 'syntaxcomplete#Complete'
  end,
})
