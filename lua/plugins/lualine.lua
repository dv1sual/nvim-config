-- lua/plugins/lualine.lua - Lualine statusline configuration

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  config = function()
    -- Custom components for lualine
    local function show_macro_recording()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "Recording @" .. recording_register
      end
    end

    local function lsp_client_names()
      local clients = {}
      local seen_clients = {}
      -- Use the new API: vim.lsp.get_clients() instead of buf_get_clients()
      local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          -- Avoid duplicates
          if not seen_clients[client.name] then
            seen_clients[client.name] = true
            table.insert(clients, client.name)
          end
        end
      end

      if next(clients) == nil then
        return "No LSP"
      end

      table.sort(clients)
      return table.concat(clients, " | ")
    end

    local function get_python_venv()
      local venv = vim.env.VIRTUAL_ENV
      if venv then
        return " " .. vim.fn.fnamemodify(venv, ":t")
      end
      return ""
    end

    local function get_attached_clients()
      -- Use the new API: vim.lsp.get_clients({ bufnr = 0 })
      local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
      if next(buf_clients) == nil then
        return ""
      end

      local clients_lsp = {}
      local seen_clients = {}
      for _, client in pairs(buf_clients) do
        -- Skip null-ls and other utility clients
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          -- Avoid duplicates
          if not seen_clients[client.name] then
            seen_clients[client.name] = true
            table.insert(clients_lsp, client.name)
          end
        end
      end

      -- Sort the client names for consistent display
      table.sort(clients_lsp)
      return " " .. table.concat(clients_lsp, " | ")
    end

    -- File size component
    local function file_size()
      local size = vim.fn.getfsize(vim.fn.expand('%:p'))
      if size <= 0 then return '' end

      local suffixes = {'B', 'KB', 'MB', 'GB'}
      local i = 1
      while size > 1024 and i < #suffixes do
        size = size / 1024
        i = i + 1
      end

      return string.format('%.1f%s', size, suffixes[i])
    end

    -- Custom mode names
    local mode_map = {
      ['n'] = 'NORMAL',
      ['no'] = 'O-PENDING',
      ['nov'] = 'O-PENDING',
      ['noV'] = 'O-PENDING',
      ['no\22'] = 'O-PENDING',
      ['niI'] = 'NORMAL',
      ['niR'] = 'NORMAL',
      ['niV'] = 'NORMAL',
      ['nt'] = 'NORMAL',
      ['v'] = 'VISUAL',
      ['vs'] = 'VISUAL',
      ['V'] = 'V-LINE',
      ['Vs'] = 'V-LINE',
      ['\22'] = 'V-BLOCK',
      ['\22s'] = 'V-BLOCK',
      ['s'] = 'SELECT',
      ['S'] = 'S-LINE',
      ['\19'] = 'S-BLOCK',
      ['i'] = 'INSERT',
      ['ic'] = 'INSERT',
      ['ix'] = 'INSERT',
      ['R'] = 'REPLACE',
      ['Rc'] = 'REPLACE',
      ['Rx'] = 'REPLACE',
      ['Rv'] = 'V-REPLACE',
      ['Rvc'] = 'V-REPLACE',
      ['Rvx'] = 'V-REPLACE',
      ['c'] = 'COMMAND',
      ['cv'] = 'EX',
      ['ce'] = 'EX',
      ['r'] = 'REPLACE',
      ['rm'] = 'MORE',
      ['r?'] = 'CONFIRM',
      ['!'] = 'SHELL',
      ['t'] = 'TERMINAL',
    }

    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'nightfox', -- matches your colorscheme
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = { 'neo-tree', 'alpha', 'dashboard' },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true, -- single statusline for all windows
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },

      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str)
              return mode_map[vim.api.nvim_get_mode().mode] or str
            end,
            icon = "",
            separator = { right = '' },
          }
        },

        lualine_b = {
          {
            'branch',
            icon = '',
            color = { fg = '#7aa2f7' },
          },
          {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            diff_color = {
              added = { fg = '#9ece6a' },
              modified = { fg = '#e0af68' },
              removed = { fg = '#f7768e' },
            },
          },
        },

        lualine_c = {
          {
            'filename',
            file_status = true,     -- Displays file status (readonly status, modified status)
            newfile_status = true,  -- Display new file status (new file means no write after created)
            path = 1,               -- 0: Just the filename
                                   -- 1: Relative path
                                   -- 2: Absolute path
                                   -- 3: Absolute path, with tilde as the home directory
            shorting_target = 40,   -- Shortens path to leave 40 spaces in the window
            symbols = {
              modified = '[+]',      -- Text to show when the file is modified.
              readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]',     -- Text to show for newly created file before first write
            },
            color = { fg = '#c0caf5' },
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_lsp' },
            sections = { 'error', 'warn', 'info', 'hint' },
            diagnostics_color = {
              error = { fg = '#f7768e' },
              warn  = { fg = '#e0af68' },
              info  = { fg = '#7dcfff' },
              hint  = { fg = '#1abc9c' },
            },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = false, -- Update diagnostics in insert mode.
            always_visible = false,   -- Show diagnostics even if there are none.
          },
        },

        lualine_x = {
          {
            show_macro_recording,
            color = { fg = '#ff9e64', gui = 'bold' },
          },
          {
            get_python_venv,
            color = { fg = '#9ece6a' },
            cond = function()
              return vim.bo.filetype == "python"
            end,
          },
          {
            get_attached_clients,
            color = { fg = '#7aa2f7' },
            cond = function()
              return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil
            end,
          },
          {
            'encoding',
            color = { fg = '#9aa5ce' },
          },
          {
            'fileformat',
            symbols = {
              unix = '', -- e712
              dos = '',  -- e70f
              mac = '', -- e711
            },
            color = { fg = '#9aa5ce' },
          },
          {
            'filetype',
            colored = true,
            icon_only = false,
            icon = { align = 'left' },
            color = { fg = '#7dcfff' },
          },
        },

        lualine_y = {
          {
            file_size,
            color = { fg = '#9aa5ce' },
          },
          {
            'progress',
            color = { fg = '#7aa2f7' },
          },
        },

        lualine_z = {
          {
            'location',
            icon = '',
            separator = { left = '' },
            color = { fg = '#c0caf5', gui = 'bold' },
          },
        }
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1,
            color = { fg = '#565f89' },
          }
        },
        lualine_x = {
          {
            'location',
            color = { fg = '#565f89' },
          }
        },
        lualine_y = {},
        lualine_z = {}
      },

      tabline = {},
      winbar = {},
      inactive_winbar = {},

      extensions = {
        'neo-tree',
        'lazy',
        'mason',
        'trouble',
        'toggleterm',
      }
    })

    -- Auto command to refresh lualine when recording macros
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        require('lualine').refresh()
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        require('lualine').refresh()
      end,
    })
  end,
}
