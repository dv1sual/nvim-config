-- lua/plugins/lazygit.lua - Lazygit integration

return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGitTab<cr>", desc = "LazyGit in new tab" },
    { "<leader>gf", "<cmd>LazyGitCurrentFileTab<cr>", desc = "LazyGit current file dir in new tab" },
    { "<leader>gl", "<cmd>LazyGitTab<cr>", desc = "LazyGit in new tab" },
  },
  config = function()
    -- Configure lazygit to open in a new tab instead of floating window
    vim.g.lazygit_use_neovim_remote = 1 -- use neovim remote for better integration
    
    -- Custom function to open lazygit in a new tab
    local function open_lazygit_in_tab()
      vim.cmd('tabnew')
      vim.cmd('terminal lazygit')
      vim.cmd('startinsert')
      -- Set buffer options for better experience
      vim.bo.buflisted = false
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.signcolumn = 'no'
    end
    
    -- Custom function to open lazygit in current file's directory in new tab
    local function open_lazygit_current_file_tab()
      local file_dir = vim.fn.expand('%:p:h')
      vim.cmd('tabnew')
      vim.cmd('terminal cd ' .. vim.fn.shellescape(file_dir) .. ' && lazygit')
      vim.cmd('startinsert')
      -- Set buffer options for better experience
      vim.bo.buflisted = false
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.signcolumn = 'no'
    end
    
    -- Override the default LazyGit commands to use tabs
    vim.api.nvim_create_user_command('LazyGitTab', open_lazygit_in_tab, { desc = 'Open LazyGit in new tab' })
    vim.api.nvim_create_user_command('LazyGitCurrentFileTab', open_lazygit_current_file_tab, { desc = 'Open LazyGit in current file directory in new tab' })
    
    -- Set up keymaps
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.silent = opts.silent ~= false
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    
    -- Git-related keymaps using tabs
    map("n", "<leader>gg", "<cmd>LazyGitTab<cr>", { desc = "Open LazyGit in new tab" })
    map("n", "<leader>gf", "<cmd>LazyGitCurrentFileTab<cr>", { desc = "LazyGit current file dir in new tab" })
    map("n", "<leader>gl", "<cmd>LazyGitTab<cr>", { desc = "Open LazyGit in new tab" })
    
    -- Optional: Add a keymap to close lazygit tab quickly
    map("t", "<C-q>", "<C-\\><C-n>:q<cr>", { desc = "Close terminal (lazygit) tab", buffer = true })
  end,
}
