local home = os.getenv('HOME')
local lsp_config = require('lspconfig')
local lsp = require("lsp-zero")
local mason = require("mason")
local mason_config = require("mason-lspconfig")

vim.filetype.add({
    pattern = {
        ["Config"] = "brazilconfig",
    }
})

lsp.preset("recommended")


mason.setup({});
mason_config.setup({
    ensure_installed = {
        'eslint',
        'tsserver',
        'rust_analyzer',
        'jdtls',
        'lua_ls',
        'jsonls',
        'pyright',
        -- 'basedpyright',
    },
    handlers = {
        function(server_name)
            if (server_name ~= 'jdtls' and server_name ~= 'basedpyright') then
                lsp_config[server_name].setup({})
            end
        end,
    },
});

-- lsp_config.basedpyright.setup{}
-- lsp_config.pyright.setup{}


local cmp = require('cmp')
cmp.setup({
    experimental = {
        ghost_text = true,
    },
})
local luasnip = require('luasnip')
local cmp_action = lsp.cmp_action()
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(cmp_select)
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<Enter>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})
cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
    }
})

-- cmp.setup({
--     -- ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--             cmp.select_prev_item(cmp_select)
--         elseif luasnip.jumpable(-1) then
--             luasnip.jump(-1)
--         else
--             fallback()
--         end
--     end, { "i", "s" }),
--     -- ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<Tab>'] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--             cmp.select_next_item()
--         elseif luasnip.expand_or_jumpable() then
--             luasnip.expand_or_jump()
--         else
--             fallback()
--         end
--     end, { "i", "s" }),
--     ['<Enter>'] = cmp.mapping.confirm({ select = true }),
--     ["<C-Space>"] = cmp.mapping.complete(),
-- })
require('Comment').setup()

-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil
-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings
-- })

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})


function bemol()
    local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory'})[1]
    local ws_folders_lsp = {}
    if bemol_dir then
        local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
        if file then

            for line in file:lines() do
                table.insert(ws_folders_lsp, line)
            end
            file:close()
        end
    end

    for _, line in ipairs(ws_folders_lsp) do
        vim.lsp.buf.add_workspace_folder(line)
    end
end

local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Check if the config is already defined (useful when reloading this file)
if not configs.barium then
    configs.barium = {
        default_config = {
            name = 'barium';
            cmd = {'barium'};
            filetypes = {'brazilconfig'};
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end;
            settings = {};
        };
    }
end
lsp.configure('barium', {force_setup = true})

local telescope = require('telescope.builtin')
lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    -- local navbuddy = require("nvim-navbuddy")
    -- navbuddy.attach(client, bufnr)

    vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
    vim.keymap.set("n", "gD", "<cmd>vsp | lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set("n", "gh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader><leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vad", function() telescope.diagnostics({bufnr=0}) end, opts)
    vim.keymap.set("n", "<leader>vpd", function() telescope.diagnostics() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>cr", telescope.lsp_references, opts)
    vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols, opts)
    vim.keymap.set("n", "<leader>ci", telescope.lsp_implementations, opts)
    vim.keymap.set("n", "<leader>cci", telescope.lsp_incoming_calls, opts)
    vim.keymap.set("n", "<leader>cco", telescope.lsp_outgoing_calls, opts)
    vim.keymap.set("n", "<leader>R", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    bemol()
end)

if not configs.codewhisperer then
    configs.codewhisperer = {
        default_config = {
            -- Add the codewhisperer to our PATH or BIN folder
            cmd = { "cwls" },
            root_dir = lspconfig.util.root_pattern("packageInfo", "package.json", "tsconfig.json", "jsconfig.json", ".git"),
            filetypes = { 'java', 'python', 'typescript', 'javascript', 'csharp', 'ruby', 'kotlin', 'shell', 'sql', 'c', 'cpp', 'go', 'rust', 'lua' },
        },
    }
end
lspconfig.codewhisperer.setup({});

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

lsp_config.pyright.setup({
    settings = {
        python = {
            analysis = {
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
                extraPaths = {
                    '/home/jpromero/.local/share/mise/installs/python/3.12/lib/python3.12/site-packages/',
                },
            },
        },
    },
});

require('mini.splitjoin').setup({
    mappings = {
        join = 'gJ',
    }
})
