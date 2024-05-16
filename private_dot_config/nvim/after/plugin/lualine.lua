require('lualine').setup({
    options = {
        theme = 'onedark',
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'diagnostics', 'branch', 'diff'},
        lualine_c = {'filename', 'searchcount', 'selectioncount'},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
})
