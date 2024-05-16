vim.keymap.set('n', '<leader><leader>g', '<Plug>(git-messenger)', {})
vim.keymap.set('n', '<leader><leader>hu', '<Plug>(GitGutterUndoHunk)', {})
vim.keymap.set('n', '<leader><leader>pr', '<Plug>(GitGutterPreviewHunk)', {})
vim.keymap.set('n', '<leader><leader>ph', '<Plug>(GitGutterPreviousHunk)', {})
vim.keymap.set('n', '<leader><leader>nh', '<Plug>(GitGutterNextHunk)', {})

require('gitblame').setup {
     --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
}
