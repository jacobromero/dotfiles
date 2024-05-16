vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.modifiable = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.statuscolumn = "%s %l %r  "

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.g.mapleader = " "
vim.opt.mouse = "nv"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = false

-- determine os version
local undodir = "/.vim/undodir"
-- if vim.fn.has('windows') then
--     undodir = "\\.vim\\undodir"
-- end
vim.opt.undodir = os.getenv("HOME") .. undodir

-- Line numbers etc in Netrw
vim.cmd([[let g:netrw_bufsettings = 'ma nomod nu nobl nowrap ro']])

-- Setup spell check
vim.opt.spelllang = 'en_us'
vim.opt.spell = false
vim.opt.spelloptions = 'camel'

vim.opt.list = true
vim.opt.listchars = {
    tab = '» ',
    trail = '·',
    nbsp = '␣',
    -- space = '·',
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }
