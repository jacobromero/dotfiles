if vim.g.vscode then
    return
end

require('mini.surround').setup({
    mappings = {
        add = '<leader>a', -- Add surrounding in Normal and Visual modes
        delete = '<leader>d', -- Delete surrounding
        replace = '<leader>r', -- Replace surrounding
        find = '', -- Find surrounding (to the right)
        find_left = '', -- Find surrounding (to the left)
        highlight = '', -- Highlight surrounding
        update_n_lines = '', -- Update `n_lines`
        suffix_last = '', -- Suffix to search with "prev" method
        suffix_next = '', -- Suffix to search with "next" method
    },
})


require('mini.indentscope').setup({
    draw = {
        -- Delay (in ms) between event and start of drawing scope indicator
        delay = 1,

        -- Animation rule for scope's first drawing. A function which, given
        -- next and total step numbers, returns wait time (in ms). See
        -- |MiniIndentscope.gen_animation| for builtin options. To disable
        -- animation, use `require('mini.indentscope').gen_animation.none()`.
        animation = require('mini.indentscope').gen_animation.none(),

        -- Symbol priority. Increase to display on top of more symbols.
        priority = 2,
    },
})
