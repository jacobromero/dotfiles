if vim.g.vscode then
    return
end

vim.keymap.set({"n"}, "<leader>vmr", "<cmd>VimuxPromptCommand<CR>")
vim.keymap.set({"n"}, "<leader>vrr", "<cmd>VimuxRunLastCommand<CR>")
