local builtin = require('telescope.builtin')

require("telescope").setup {
    defaults = {
        wrap_results = true,
        path_display = {"filename_first"},
    },
    pickers = {
        find_files = {
            mappings = {
                n = {
                    ["cd"] = function(prompt_bufnr)
                        local selection = require("telescope.actions.state").get_selected_entry()
                        local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                        require("telescope.actions").close(prompt_bufnr)
                        -- Depending on what you want put `cd`, `lcd`, `tcd`
                        vim.cmd(string.format("silent lcd %s", dir))
                    end
                }
            }
        },
    }
}
require("telescope").load_extension("ui-select")

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

function live_grep_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    local git_root = vim.fn.fnamemodify(dot_git_path, ":h")

	local opts = { cwd = git_root }

	require("telescope.builtin").live_grep(opts)
end

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n','<leader>gf', ':lua require("telescope.builtin").git_files({ use_file_path = true })<CR>', {})
vim.keymap.set('n','<leader><leader>gf', function() live_grep_git_root() end, {})
-- vim.keymap.set('n','<leader><leader>gs', ':lua require("telescope.builtin").git_status({ use_file_path = true, initial_mode = "normal" })<CR>', {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-F>', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('v', '<C-f>', function()
	local text = vim.getVisualSelection()
	builtin.live_grep({ default_text = text })
end, opts)

-- local highlights = {
--   -- Used for highlighting the matched line inside Previewer. Works only for (vim_buffer_ previewer)
--   TelescopePreviewLine = {  bg="#3B4252", fg="#5E81AC" },
--   TelescopePreviewMatch = {  bg="#3B4252", fg="#5E81AC" },
-- }
-- for k, v in pairs(highlights) do
--   vim.api.nvim_set_hl(0, k, v)
-- end
vim.api.nvim_set_hl(0, "TelescopeSelection", {bg="#263352", bold=true, standout=true,})
vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", {bg="#263352", bold=true, standout=true,})
vim.api.nvim_set_hl(0, "Search", {bg="#757265", standout=true,})

