-- lua/plugins/gitsigns.lua - Git integration with gitsigns

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable for files longer than 40K lines
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'rounded',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
    
    -- Define color highlights for git signs
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitSignsChange' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })
    vim.api.nvim_set_hl(0, 'GitSignsUntracked', { link = 'GitSignsAdd' })
    
    -- Set up keymaps
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = true
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    
    -- Git navigation and actions
    local gs = require('gitsigns')
    
    -- Navigation between git hunks
    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gs.nav_hunk('next')
      end
    end, { desc = 'Next git hunk' })

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gs.nav_hunk('prev')
      end
    end, { desc = 'Previous git hunk' })

    -- Git actions (updated to avoid conflicts with GitHub review)
    vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage hunk' })
    vim.keymap.set('n', '<leader>ghr', gs.reset_hunk, { desc = 'Reset hunk' })  -- Changed from gr to ghr
    vim.keymap.set('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk' })
    vim.keymap.set('v', '<leader>ghr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk' })  -- Changed from gr
    vim.keymap.set('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
    vim.keymap.set('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
    vim.keymap.set('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
    vim.keymap.set('n', '<leader>ghp', gs.preview_hunk, { desc = 'Preview hunk' })  -- Changed from gp to ghp
    vim.keymap.set('n', '<leader>gb', function() gs.blame_line{full=true} end, { desc = 'Blame line' })
    vim.keymap.set('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'Toggle line blame' })
    vim.keymap.set('n', '<leader>gd', gs.diffthis, { desc = 'Diff this' })
    vim.keymap.set('n', '<leader>gD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
    
    -- Git text objects
    vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select git hunk' })
    
    -- Toggle options
    vim.keymap.set('n', '<leader>gt', gs.toggle_signs, { desc = 'Toggle git signs' })
    vim.keymap.set('n', '<leader>gh', gs.toggle_linehl, { desc = 'Toggle line highlight' })
    vim.keymap.set('n', '<leader>gwd', gs.toggle_word_diff, { desc = 'Toggle word diff' })  -- Changed from gw to gwd
    
    -- Telescope integration (if available)
    pcall(function()
      require('telescope').load_extension('git_status')
      require('telescope').load_extension('git_commits')
      require('telescope').load_extension('git_bcommits')
    end)
  end,
}