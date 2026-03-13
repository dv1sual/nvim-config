-- lua/plugins/noice.lua
-- Replaces the cmdline, messages, and notifications with floating UI

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      opts = {
        timeout = 3000,
        max_height = function() return math.floor(vim.o.lines * 0.75) end,
        max_width  = function() return math.floor(vim.o.columns * 0.75) end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
        render = "compact",
        stages = "fade",
        background_colour = "#192330",
      },
    },
  },
  opts = {
    lsp = {
      override = {
        -- Use noice's markdown renderer for LSP hover/signature
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      progress = {
        enabled = true,
        format = "lsp_progress",
        format_done = "lsp_progress_done",
        throttle = 1000 / 30,
        view = "mini",
      },
    },
    presets = {
      -- Floating cmdline centered on screen + popup menu right below it
      command_palette       = true,
      -- Long :messages go to a split instead of flooding the screen
      long_message_to_split = true,
      -- Adds a border to LSP hover docs
      lsp_doc_border        = true,
    },
    routes = {
      -- Send short write messages ("12L, 300B written") to the mini view
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "^%d+ line" },
          },
        },
        view = "mini",
      },
      -- Suppress "written" noise entirely
      {
        filter = { event = "msg_show", find = '".*" %d+L' },
        opts  = { skip = true },
      },
    },
  },
  keys = {
    { "<leader>nl", function() require("noice").cmd("last")    end, desc = "Noice last message" },
    { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice history" },
    { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss notifications" },
  },
}
