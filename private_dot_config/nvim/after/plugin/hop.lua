local hop = require('hop')
hop.setup()
vim.keymap.set({"n", "v"}, "<leader>w", hop.hint_words, {silent = true})
vim.keymap.set({"n", "v"}, "<leader>f", hop.hint_char1, {silent = true})
vim.keymap.set({"n", "v"}, "<leader>F", hop.hint_char2, {silent = true})
vim.keymap.set({"n", "v"}, "<leader>l", hop.hint_lines_skip_whitespace, {silent = true})
vim.keymap.set({"n", "v"}, "<leader>/", hop.hint_patterns, {silent = true})
