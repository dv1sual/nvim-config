-- lua/plugins/dash.lua
local logo = [[

██████╗ ██╗   ██╗ ██╗███████╗██╗   ██╗ █████╗ ██╗     
██╔══██╗██║   ██║███║██╔════╝██║   ██║██╔══██╗██║     
██║  ██║██║   ██║╚██║███████╗██║   ██║███████║██║     
██║  ██║╚██╗ ██╔╝ ██║╚════██║██║   ██║██╔══██║██║     
██████╔╝ ╚████╔╝  ██║███████║╚██████╔╝██║  ██║███████╗
╚═════╝   ╚═══╝   ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝
                                                      
]]

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- Add spacing before center content to push it down
        center = {
          { 
            action = function() 
              require("lazy").load({ plugins = { "telescope.nvim" } })
              require("telescope.builtin").find_files() 
            end,                           
            desc = " Find File",       
            icon = " ", 
            key = "f" 
          },
          { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
          { 
            action = function() 
              require("lazy").load({ plugins = { "telescope.nvim" } })
              require("telescope.builtin").oldfiles() 
            end,                            
            desc = " Recent Files",    
            icon = " ", 
            key = "r" 
          },
          { 
            action = function() 
              require("lazy").load({ plugins = { "telescope.nvim" } })
              require("telescope.builtin").live_grep() 
            end,                           
            desc = " Find Text",       
            icon = " ", 
            key = "g" 
          },
          { 
            action = function() 
              require("lazy").load({ plugins = { "telescope.nvim" } })
              require("telescope.builtin").find_files({ cwd = vim.fn.expand("~/.config/nvim") }) 
            end, 
            desc = " Config",          
            icon = " ", 
            key = "c" 
          },
          { action = function() require("persistence").load() end,     desc = " Restore Session", icon = " ", key = "s" },
          { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }
    
    -- Calculate dynamic spacing for centering
    local header_height = #opts.config.header
    local center_height = #opts.config.center
    local footer_height = 1
    local total_content_height = header_height + center_height + footer_height + 4 -- +4 for spacing
    local screen_height = vim.o.lines
    local vertical_padding = math.max(0, math.floor((screen_height - total_content_height) / 2))
    
    -- Add empty lines at the top of header for vertical centering
    local centered_header = {}
    for i = 1, vertical_padding do
      table.insert(centered_header, "")
    end
    for _, line in ipairs(opts.config.header) do
      table.insert(centered_header, line)
    end
    opts.config.header = centered_header
    
    -- Center the button text horizontally
    for _, button in ipairs(opts.config.center) do
      local button_text = button.icon .. button.desc
      local padding = math.max(0, math.floor((vim.o.columns - #button_text) / 2))
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end
    
    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end
    return opts
  end,
}
