vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.showmode = false
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- vim.keymap.set("n", "<leader>pv", ":Neotree reveal position=current<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set({"n", "v", "t"}, "<leader>y", "\"*y")
vim.keymap.set("n", "<leader>y", "\"*y")
vim.keymap.set("v", "<leader>y", "\"*y")
vim.keymap.set("n", "<leader>Y", "\"*Y")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-L>", "20zl")
vim.keymap.set("n", "<C-H>", "20zh")

vim.keymap.set({"n", "i", "l", "v", "t", "c", "o", "x", "s"}, "<C-h>", ":wincmd h<CR>", {silent=true, remap=true})
vim.keymap.set({"n", "i", "l", "v", "t", "c", "o", "x", "s"}, "<C-j>", ":wincmd j<CR>", {silent=true, remap=true})
vim.keymap.set({"n", "i", "l", "v", "t", "c", "o", "x", "s"}, "<C-k>", ":wincmd k<CR>", {silent=true, remap=true})
vim.keymap.set({"n", "i", "l", "v", "t", "c", "o", "x", "s"}, "<C-l>", ":wincmd l<CR>", {silent=true, remap=true})

vim.keymap.set({"n", "i", "l", "v", "t", "c", "o", "x", "s"}, "<SC-L>", ":wincmd L<CR>", {silent=true, remap=true})
vim.keymap.set({"n", "i", "l", "v", "t", "c", "o", "x", "s"}, "<SC-H>", ":wincmd R<CR>", {silent=true, remap=true})
vim.keymap.set({"n", "i", "l", "v", "t", "c", "o", "x", "s"}, "<SC-J>", ":wincmd J<CR>", {silent=true, remap=true})
vim.keymap.set({"n", "i", "l", "v", "t", "c", "o", "x", "s"}, "<SC-K>", ":wincmd K<CR>", {silent=true, remap=true})

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- vim.keymap.set("n", "<C-[>", "<C-w>5>", {remap=true})
-- vim.keymap.set("n", "<C-]>", "<C-w>5<", {remap=true})

-- vim.keymap.set("i", "<C-BS>", "<C-W>", {silent=true})
-- vim.keymap.set({"c", "o", "t"}, "<C-BS>", "<C-W>", {silent=true, remap=true})
-- vim.keymap.set("n", "<C-BS>", "i<C-W><Esc>", {silent=true})

vim.keymap.set("n", "gp", "<C-^>", {silent=true})

vim.keymap.set("n", "<C-t>", "<C-e>", {silent=true})

vim.keymap.set("n", "0", "^", {silent=true, remap=true})

-- vim.keymap.set("i", "<D-Left>", "<C-o>b", {silent=true})
-- vim.keymap.set("i", "<D-Right>", "<C-o>w", {silent=true})

vim.keymap.set("i", "<C-a>", "<Esc>^i", {silent=true})
vim.keymap.set("i", "<M-left>", "<C-left>", {silent=true, remap=true})
vim.keymap.set("i", "<M-right>", "<C-right>", {silent=true, remap=true})
vim.keymap.set("i", "<M-BS>", "<C-w>", {silent=true, remap=true})
vim.keymap.set("i", "<M-u>", "<c-o>u", {silent=true, remap=true})
vim.keymap.set("i", "<M-r>", "<c-o><c-r>", {silent=true, remap=true})


vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end, {silent=true, remap=true})

-- jump to another tab
vim.keymap.set({"n", "l", "v", "t", "o", "x", "s"}, "<leader>1", "1gt", {silent=true, remap=true})
vim.keymap.set({"n", "l", "v", "t", "o", "x", "s"}, "<leader>2", "2gt", {silent=true, remap=true})
vim.keymap.set({"n", "l", "v", "t", "o", "x", "s"}, "<leader>3", "3gt", {silent=true, remap=true})
vim.keymap.set({"n", "l", "v", "t", "o", "x", "s"}, "<leader>4", "4gt", {silent=true, remap=true})
vim.keymap.set({"n", "l", "v", "t", "o", "x", "s"}, "<leader>5", "5gt", {silent=true, remap=true})

-- vim.keymap.set({"n", "l", "v", "t", "o", "x", "s"}, "<leader><leader>n", ":noh<CR>", {silent=true, remap=true})
vim.keymap.set({"n"}, "<Esc>", "<cmd>nohlsearch<CR>")

-- Create user commands for common functions but do not want keybinds for.
vim.api.nvim_create_user_command('Jq', '%!jq .', {})

-- Resizes

vim.api.nvim_create_user_command("Vr", function(opts)
    local usage = "Usage: [VirticalResize] :Vr {number (%)}"
    if not opts.args or not string.len(opts.args) == 2 then
        print(usage)
        return
    end
    vim.cmd(":vertical resize " .. vim.opt.columns:get() * (opts.args / 100.0))
end, { nargs = "*" })

vim.api.nvim_create_user_command("Hr", function(opts)
    local usage = "Usage: [HorizontalResize] :Hr {number (%)}"
    if not opts.args or not string.len(opts.args) == 2 then
        print(usage)
        return
    end
    vim.cmd(
        ":resize "
            .. (
                (vim.opt.lines:get() - vim.opt.cmdheight:get())
                * (opts.args / 100.0)
            )
    )
end, { nargs = "*" })

function resize(direction, dir, count)
    if vim.fn.winnr('$') == 1 then
        return
    end

    local cmd_dir = dir

    if vim.fn.winnr() == vim.fn.winnr('$') then
        cmd_dir = not dir
    end

    local resize_dir = cmd_dir and '+' or '-'
    vim.cmd(direction .. ' resize ' .. resize_dir .. count)
end

vim.api.nvim_set_keymap('n', '<M-right>', ':lua resize("vert", true, 3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-left>', ':lua resize("vert", false, 3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-up>', ':lua resize("horizontal", false, 3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-down>', ':lua resize("horizontal", true, 3)<CR>', { noremap = true, silent = true })
-- vim.keymap.set({"n" }, "<M-left>", "<C-w>5<", {silent=true, remap=true})
-- vim.keymap.set({"n"}, "<M-right>", "<C-w>5>", {silent=true, remap=true})remremremrem
