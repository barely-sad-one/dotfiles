return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        local key = vim.keymap.set

        key('n', '<leader>pf', builtin.find_files, {})
        key('n', '<C-p>', builtin.git_files, {})
        key('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input('Grep find> ') })
        end)

     end,
}
