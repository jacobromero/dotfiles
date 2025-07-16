if vim.g.vscode then
    require('vscode-multi-cursor').setup { -- Config is optional
      -- Whether to set default mappings
      default_mappings = true,
      -- If set to true, only multiple cursors will be created without multiple selections
      no_selection = false
    }
end
