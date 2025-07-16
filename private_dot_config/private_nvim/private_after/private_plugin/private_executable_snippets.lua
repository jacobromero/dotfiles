if vim.g.vscode then
    return
end

local ls = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

vim.keymap.set({"i", "s"}, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, {silent = true})
