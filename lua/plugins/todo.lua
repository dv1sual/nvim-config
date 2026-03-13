-- lua/plugins/todo.lua - Highlight and search TODO / FIXME / HACK / NOTE etc.
--
-- ]t / [t         → jump to next / previous todo comment
-- <leader>ft      → search all todos via Telescope
-- <leader>xt      → show todos in Trouble panel

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = true,
    keywords = {
      FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = "󰅒 ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = "󰍨 ", color = "hint",    alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test",    alt = { "TESTING", "PASSED", "FAILED" } },
    },
  },
  keys = {
    { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t",         function() require("todo-comments").jump_prev() end, desc = "Prev todo comment" },
    { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Find TODOs" },
    { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "TODOs (Trouble)" },
  },
}
