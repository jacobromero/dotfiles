require("toggleterm").setup {
    size = 125,
    persist_size = false,
    hide_numbers = false,
}

vim.keymap.set({"n", "v", "t"}, "<leader><leader>t", ":ToggleTerm direction=vertical <CR>", {silent = true})
vim.keymap.set({"n", "v", "t"}, "<leader><leader>ft", ":ToggleTerm direction=float <CR>", {silent = true})
