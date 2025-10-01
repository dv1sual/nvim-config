-- lua/plugins/indent.lua - Indentation guides and scope highlighting

return {
  -- Indent guides with scope highlighting
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│", -- Character for indent lines
        tab_char = "│",
        highlight = { "IblIndent" },
        smart_indent_cap = true,
      },
      whitespace = {
        highlight = { "IblWhitespace" },
        remove_blankline_trail = true,
      },
      scope = {
        enabled = true,
        char = "│",
        highlight = { "IblScope" },
        show_start = true,
        show_end = true,
        show_exact_scope = false,
        injected_languages = true,
        include = {
          node_type = {
            ["*"] = {
              "class",
              "return_statement",
              "function",
              "method",
              "^if",
              "^while",
              "jsx_element",
              "^for",
              "^object",
              "^table",
              "block",
              "arguments",
              "if_statement",
              "else_clause",
              "jsx_element",
              "jsx_self_closing_element",
              "try_statement",
              "catch_clause",
              "import_statement",
              "operation_type",
            },
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
      
      -- Custom highlight groups for better colors
      local hooks = require("ibl.hooks")
      
      -- Set up rainbow colors for indentation
      local highlight = {
        "RainbowRed",
        "RainbowYellow", 
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        
        -- Set scope highlight to be more prominent
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#61AFEF", bold = true })
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B4048" })
      end)
      
      -- Optional: Enable rainbow indent for specific file types
      vim.g.rainbow_delimiters = { highlight = highlight }
    end,
  },

  -- Better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
    },
    event = "BufReadPost",
    opts = {
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_ft = {
        default = {'imports', 'comment'},
        json = {'array'},
        c = {'comment', 'region'}
      },
      preview = {
        win_config = {
          border = {'', '─', '', '', '', '─', '', ''},
          winhighlight = 'Normal:Folded',
          winblend = 0
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']'
        }
      },
      provider_selector = function(bufnr, filetype, buftype)
        -- Use treesitter for folding when available, fallback to indent
        return {'treesitter', 'indent'}
      end
    },
    init = function()
      -- Configure folding
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      local ufo = require('ufo')
      ufo.setup(opts)
      
      -- Folding keymaps
      vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds, { desc = 'Open folds except kinds' })
      vim.keymap.set('n', 'zm', ufo.closeFoldsWith, { desc = 'Close folds with' })
      vim.keymap.set('n', 'zp', function()
        local winid = ufo.peekFoldedLinesUnderCursor()
        if not winid then
          -- Choose one of the coc.nvim and nvim lsp
          vim.lsp.buf.hover()
        end
      end, { desc = 'Peek fold' })
    end,
  },

  -- Enhanced current line highlighting
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
      filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
        'neo-tree',
        'alpha',
        'NvimTree',
        'lazy',
        'neogitstatus',
        'Trouble',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'DressingSelect',
        'TelescopePrompt',
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      
      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end
      
      map("]]", "next")
      map("[[", "prev")
      
      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  -- Rainbow delimiters for better bracket/parentheses visibility
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
      
      -- Set up highlights that work well with nightfox
      vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#E06C75' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#E5C07B' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#61AFEF' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#D19A66' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#98C379' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#C678DD' })
      vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#56B6C2' })
    end,
  },
}