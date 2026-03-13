-- lua/plugins/trouble.lua - Better diagnostics / quickfix / LSP panel
--
-- <leader>xx  → workspace diagnostics
-- <leader>xX  → buffer diagnostics
-- <leader>xs  → symbols outline
-- <leader>xl  → LSP definitions / references (right panel)
-- <leader>xq  → quickfix list
-- <leader>xL  → location list

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Trouble" },
  opts = {
    modes = {
      lsp = {
        win = { position = "right" },
      },
    },
  },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
    { "<leader>xs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
    { "<leader>xl", "<cmd>Trouble lsp toggle win.position=right<cr>",   desc = "LSP (Trouble)" },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location list (Trouble)" },
  },
}
