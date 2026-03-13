-- lua/plugins/lualine.lua — bubbles style
--
-- Sections:
--   a  short mode label (N / I / V / R / C / T)
--   b  git branch + diff
--   c  filename · diagnostics · macro recording · navic breadcrumbs
--   x  search count · indent info · encoding* · fileformat* · lsp · venv · filetype
--   y  progress
--   z  location
--   (* shown only when non-standard)

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "SmiteshP/nvim-navic",
      opts = {
        separator         = "  ",
        highlight         = true,
        depth_limit       = 5,
        lazy_update_context = true,
      },
    },
  },
  event = "VeryLazy",
  config = function()

    local colors = {
      bg      = "#192330",
      fg      = "#c0caf5",
      blue    = "#719cd6",
      green   = "#81b29a",
      yellow  = "#dbc074",
      red     = "#c94f6d",
      magenta = "#9d79d6",
      cyan    = "#63cdcf",
      grey    = "#29394f",
      dim     = "#738091",
    }

    local theme = {
      normal   = { a = { fg = colors.bg, bg = colors.blue,    gui = "bold" },
                   b = { fg = colors.fg, bg = colors.grey },
                   c = { fg = colors.fg, bg = colors.bg } },
      insert   = { a = { fg = colors.bg, bg = colors.green,   gui = "bold" } },
      visual   = { a = { fg = colors.bg, bg = colors.magenta, gui = "bold" } },
      replace  = { a = { fg = colors.bg, bg = colors.red,     gui = "bold" } },
      command  = { a = { fg = colors.bg, bg = colors.yellow,  gui = "bold" } },
      terminal = { a = { fg = colors.bg, bg = colors.cyan,    gui = "bold" } },
      inactive = { a = { fg = colors.grey, bg = colors.bg },
                   b = { fg = colors.grey, bg = colors.bg },
                   c = { fg = colors.grey, bg = colors.bg } },
    }

    -- ── Components ────────────────────────────────────────────────────────────

    -- Short mode label — the color bubble already communicates the mode visually
    local MODE_LABELS = {
      n       = "N",    no  = "N·O",
      i       = "I",    ic  = "I",    ix  = "I",
      v       = "V",    V   = "V·L",
      ["\22"] = "V·B",
      s       = "S",    S   = "S·L",
      ["\19"] = "S·B",
      R       = "R",    Rc  = "R",    Rv  = "R·V",
      c       = "C",    cv  = "C",
      t       = "T",
    }

    local function mode_label()
      return MODE_LABELS[vim.fn.mode()] or vim.fn.mode():upper()
    end

    -- Macro recording — shown in red while recording
    local function macro_rec()
      local reg = vim.fn.reg_recording()
      return reg ~= "" and ("● @" .. reg) or ""
    end

    -- Navic breadcrumbs (requires LSP with documentSymbols support)
    local function navic_location()
      local ok, navic = pcall(require, "nvim-navic")
      return (ok and navic.is_available()) and navic.get_location() or ""
    end
    local function navic_cond()
      local ok, navic = pcall(require, "nvim-navic")
      return ok and navic.is_available() and navic.get_location() ~= ""
    end

    -- LSP clients attached to the current buffer
    local function lsp_clients()
      local clients = {}
      for _, c in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if c.name ~= "null-ls" and c.name ~= "copilot" then
          table.insert(clients, c.name)
        end
      end
      table.sort(clients)
      return #clients > 0 and ("  " .. table.concat(clients, " · ")) or ""
    end

    -- Python virtual env name
    local function python_venv()
      local v = vim.env.VIRTUAL_ENV
      return v and (" " .. vim.fn.fnamemodify(v, ":t")) or ""
    end

    -- Indent style — hidden when using the default (4 spaces)
    local function indent_info()
      local expandtab  = vim.bo.expandtab
      local sw         = vim.bo.shiftwidth ~= 0 and vim.bo.shiftwidth or vim.bo.tabstop
      if expandtab and sw == 4 then return "" end
      return (expandtab and "·" or "⇥") .. sw
    end

    -- ── Layout ────────────────────────────────────────────────────────────────

    require("lualine").setup({
      options = {
        theme                = theme,
        globalstatus         = true,
        component_separators = { left = "│", right = "│" },
        section_separators   = { left = "", right = "" },
        disabled_filetypes   = { statusline = { "dashboard", "neo-tree" } },
      },

      sections = {
        lualine_a = {
          { mode_label, padding = { left = 1, right = 2 } },
        },
        lualine_b = {
          { "branch", icon = "" },
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        },
        lualine_c = {
          { "filename", path = 1,
            symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" } },
          { "diagnostics", sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " } },
          { macro_rec,
            color = { fg = colors.red, gui = "bold" },
            cond  = function() return vim.fn.reg_recording() ~= "" end },
          { navic_location,
            cond  = navic_cond,
            color = { fg = colors.dim } },
        },
        lualine_x = {
          { "searchcount",
            maxcount = 999, timeout = 500,
            color    = { fg = colors.yellow } },
          { indent_info,
            color = { fg = colors.dim },
            cond  = function() return indent_info() ~= "" end },
          { "encoding",
            cond  = function() return (vim.bo.fenc or vim.o.enc):lower() ~= "utf-8" end,
            color = { fg = colors.yellow } },
          { "fileformat",
            cond  = function() return vim.bo.fileformat ~= "unix" end,
            color = { fg = colors.yellow },
            icons_enabled = true },
          { lsp_clients, color = { fg = colors.blue } },
          { python_venv,
            color = { fg = colors.green },
            cond  = function() return vim.bo.filetype == "python" end },
          { "filetype", colored = true },
        },
        lualine_y = {
          { "progress", padding = { left = 2, right = 1 } },
        },
        lualine_z = {
          { "location", padding = { left = 1, right = 1 } },
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1, color = { fg = colors.grey } } },
        lualine_x = { { "location",            color = { fg = colors.grey } } },
        lualine_y = {},
        lualine_z = {},
      },

      extensions = { "neo-tree", "lazy", "mason", "toggleterm" },
    })
  end,
}
