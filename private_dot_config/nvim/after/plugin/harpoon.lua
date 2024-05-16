local harpoon = require('harpoon')

-- require("harpoon").setup({
--     menu = {
--         width = 90,
--     }
-- })

-- vim.keymap.set("n", "<C-e>", harpoon.ui:toggle_quick_menu, {remap=true})
-- vim.keymap.set("n", "<leader>a", mark.add_file)
-- vim.keymap.set("x", "<leader>a", mark.add_file)

harpoon:setup({})

vim.keymap.set("n", "<leader>mf", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

