-- lua/plugins/flash.lua - Fast motion / jump plugin
--
-- s       → jump to any visible position by label
-- S       → treesitter-aware jump (selects AST nodes)
-- r       → remote flash (operator-pending: act on distant text without moving)
-- R       → treesitter search across the buffer
-- <C-s>   → toggle flash inside / search (/)

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        jump_labels = true,   -- show jump labels on f / t / F / T
      },
    },
  },
  keys = {
    { "s",     function() require("flash").jump() end,              mode = { "n", "x", "o" }, desc = "Flash jump" },
    { "S",     function() require("flash").treesitter() end,        mode = { "n", "x", "o" }, desc = "Flash treesitter" },
    { "r",     function() require("flash").remote() end,            mode = "o",               desc = "Flash remote" },
    { "R",     function() require("flash").treesitter_search() end, mode = { "o", "x" },      desc = "Flash treesitter search" },
    { "<C-s>", function() require("flash").toggle() end,            mode = { "c" },           desc = "Toggle flash search" },
  },
}
