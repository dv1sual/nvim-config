-- lua/core/claude.lua
-- Toggle Claude Code CLI in a vertical split on the right

local claude_buf = nil

local function toggle_claude()
  -- If the buffer is already visible in a window, close that window
  if claude_buf and vim.api.nvim_buf_is_valid(claude_buf) then
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == claude_buf then
        if #vim.api.nvim_list_wins() > 1 then
          vim.api.nvim_win_close(win, true)
        end
        return
      end
    end
  end

  -- Open a vertical split on the right, sized to 40% of the screen
  local width = math.floor(vim.o.columns * 0.40)
  vim.cmd("botright " .. width .. "vsplit")
  vim.cmd("terminal claude")
  vim.cmd("startinsert")

  claude_buf = vim.api.nvim_get_current_buf()
  vim.bo.buflisted = false
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = "no"
  vim.wo.statusline = " "

  -- Clean up buffer reference when the terminal closes
  vim.api.nvim_buf_attach(claude_buf, false, {
    on_detach = function()
      claude_buf = nil
    end,
  })
end

vim.api.nvim_create_user_command("ClaudeCode", toggle_claude, {
  desc = "Toggle Claude Code CLI in a vertical split",
})

vim.keymap.set("n", "<leader>ac", toggle_claude, {
  desc = "Toggle Claude Code",
  silent = true,
})

-- Close the split from inside terminal mode with Ctrl+Q
vim.keymap.set("t", "<C-q>", function()
  vim.cmd("stopinsert")
  toggle_claude()
end, {
  desc = "Close Claude Code split",
  silent = true,
})
