-- lua/plugins/autopairs.lua
-- Auto-closes (), [], {}, "", '' as you type

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true, -- use treesitter to check for pairs
    })

    -- Integration with nvim-cmp: when you select a completion item with `(`,
    -- autopairs will automatically add the closing `)`.
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
