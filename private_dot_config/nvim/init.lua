require("jpromero")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-live-grep-args.nvim" ,
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'tanvirtin/monokai.nvim' },
    {
        "nvim-treesitter/nvim-treesitter",
        -- build = ":TSUpdate",
        -- config = function ()
        --     local configs = require("nvim-treesitter.configs")
        --
        --     configs.setup({
        --         -- ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
        --         sync_install = false,
        --         highlight = { enable = true },
        --         indent = { enable = true },
        --     })
        -- end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter" },
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'hrsh7th/nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip' },
    -- { 'saadparwaiz1/cmp-nvim-lsp' },
    {
        'L3MON4D3/LuaSnip',
        dependencies = {'nvim-cmp'},
    },
    { "rafamadriz/friendly-snippets" },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',             -- Required
            'williamboman/mason.nvim',           -- Optional
            'williamboman/mason-lspconfig.nvim', -- Optional

            -- Autocompletion
            'hrsh7th/nvim-cmp',     -- Required
            'hrsh7th/cmp-nvim-lsp', -- Required
            'L3MON4D3/LuaSnip',     -- Required
        }
    },
    { 'numToStr/Comment.nvim' },
    { 'mfussenegger/nvim-jdtls' },
    { 'smoka7/hop.nvim' },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup()
        end
    },
    { 'airblade/vim-gitgutter' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-dap.nvim' },
    {
        'matbme/JABS.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'},
    {
        url = "jpromero@git.amazon.com:pkg/NinjaHooks",
        branch = "mainline",
        rtp = 'configuration/vim/amazon/brazil-config',
        enabled = function ()
            return false
        end
    },
    { 'christoomey/vim-tmux-navigator' },
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    { 'rhysd/git-messenger.vim' },
    { 'nyngwang/Neozoom.lua' },
    { 'f-person/git-blame.nvim' },
    {
        "cshuaimin/ssr.nvim",
        module = "ssr",
        -- Calling setup is optional.
        config = function()
            require("ssr").setup {
                border = "rounded",
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                adjust_window = true,
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_confirm = "<cr>",
                    replace_all = "<leader><cr>",
                },
            }
        end
    },
    { 'chentoast/marks.nvim' },
    { 'exafunction/codeium.vim' },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            "nvim-neotest/nvim-nio"
        },
    },
    { 'folke/neodev.nvim' },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap"},
    },
    { 'echasnovski/mini.splitjoin' },
    { 'echasnovski/mini.surround', version = '*' },
    { 'echasnovski/mini.indentscope', version = '*' },
    { 'mg979/vim-visual-multi' },
    -- {
    --     "smoka7/multicursors.nvim",
    --     dependencies = {
    --         'smoka7/hydra.nvim',
    --     },
    -- },
    { 'nomnivore/ollama.nvim' },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
        "amitds1997/remote-nvim.nvim",
        version = "*", -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim", -- For standard functions
            "MunifTanjim/nui.nvim", -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        config = true,
    },
    {
        "mikavilpas/yazi.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        keys = {
            {
                -- 👇 choose your own keymapping
                "<leader>-",
                function()
                    require("yazi").yazi()
                end,
                { desc = "Open the file manager" },
            },
        },
        ---@type YaziConfig
        opts = {
            open_for_directories = false,
        },
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('render-markdown').setup({})
        end,
    },
    {
        'preservim/vimux',
    }
}, opt);

if vim.g.vscode then
    require('jpromero')
end
