if vim.g.vscode then
    return
end

require('neo-zoom').setup{
    winopts = {
        offset = {
            width = 0.95,
            height = 0.95,
        },
    },
}
vim.keymap.set('n', '<leader><leader>z', function() vim.cmd('NeoZoomToggle') end, {silent=true})
