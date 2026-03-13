-- lua/plugins/dash.lua

local day_colors = {
  Monday    = "#719cd6",
  Tuesday   = "#81b29a",
  Wednesday = "#dbc074",
  Thursday  = "#9d79d6",
  Friday    = "#c94f6d",
  Saturday  = "#63cdcf",
  Sunday    = "#d16983",
}

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local today = tostring(os.date("%A"))
    local color = day_colors[today] or "#dbc074"

    require("dashboard").setup({
      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            icon = "󰊳 ",
            desc = "Update",
            group = "@property",
            action = "Lazy update",
            key = "u",
          },
          {
            icon = " ",
            desc = "Files",
            group = "DiagnosticHint",
            action = function()
              require("lazy").load({ plugins = { "telescope.nvim" } })
              require("telescope.builtin").find_files()
            end,
            key = "f",
          },
          {
            icon = "󰒲 ",
            desc = "Lazy",
            group = "DiagnosticInfo",
            action = "Lazy",
            key = "l",
          },
          {
            icon = " ",
            desc = "dotfiles",
            group = "Number",
            action = function()
              require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
            end,
            key = "d",
          },
          {
            icon = " ",
            desc = "Quit",
            group = "DiagnosticError",
            action = "qa",
            key = "q",
          },
        },
        packages = { enable = true },
        project = {
          enable = true,
          limit = 8,
          icon = "󰀿 ",
          label = " Recently Projects:",
          action = "Telescope find_files cwd=",
        },
        mru = {
          limit = 10,
          icon = "󱋢 ",
          label = " Most Recent Files:",
          cwd_only = false,
        },
        footer = function()
          return { "", "neovim,  btw." }
        end,
      },
    })

    local function apply_day_hl()
      vim.api.nvim_set_hl(0, "DashboardHeader",  { fg = color, bold = true })
      vim.api.nvim_set_hl(0, "DashboardWeekDay", { fg = "#738091" })
    end

    apply_day_hl()
    -- Re-apply after colorscheme loads (nordfox resets these)
    vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_day_hl })
  end,
}
