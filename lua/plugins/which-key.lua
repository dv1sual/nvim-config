-- lua/plugins/which-key.lua - Which-key plugin configuration

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      preset = "helix",  -- This should give you right-side vertical layout
      delay = 300,
      expand = 1,
      notify = true,
      
      win = {
        border = "rounded",
        padding = { 1, 2 },
        title = " Which Key ",
        title_pos = "center",
        wo = {
          winblend = 10,
        },
      },
      
      layout = {
        spacing = 1,
        align = "left",
      },
      
      keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      
      sort = { "local", "order", "group", "alphanum", "mod" },
      
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
        },
        desc = {
          { "<Plug>%(?(.*)%)?", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
      
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        mappings = true,
        rules = {},
        colors = true,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },
      
      show_help = true,
      show_keys = true,
      
      disable = {
        ft = {},
        bt = {},
      },
      debug = false,
    })
    
    -- Register key mappings with descriptions
    wk.add({
      -- File operations
      { "<leader>f", group = "Find" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Live Grep" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fh", desc = "Help Tags" },
      { "<leader>fr", desc = "Recent Files" },
      { "<leader>fc", desc = "Find Word Under Cursor" },
      { "<leader>fk", desc = "Keymaps" },
      { "<leader>fs", desc = "Git Status" },
      { "<leader>fd", desc = "Diagnostics" },
      
      -- Neo-tree
      { "<leader>e", desc = "Toggle Neo-tree" },
      { "<leader>o", desc = "Focus Neo-tree" },
      
      -- Buffer operations  
      { "<leader>b", group = "Buffer" },
      { "<S-h>", desc = "Previous Buffer" },
      { "<S-l>", desc = "Next Buffer" },
      
      -- Window operations
      { "<leader>w", group = "Window" },
      { "<C-h>", desc = "Go to Left Window" },
      { "<C-j>", desc = "Go to Lower Window" },
      { "<C-k>", desc = "Go to Upper Window" },
      { "<C-l>", desc = "Go to Right Window" },
      { "<C-Up>", desc = "Increase Window Height" },
      { "<C-Down>", desc = "Decrease Window Height" },
      { "<C-Left>", desc = "Decrease Window Width" },
      { "<C-Right>", desc = "Increase Window Width" },
      
      -- Git operations (Updated for LazyGit + GitSigns + GitHub PR Review)
      { "<leader>g", group = "Git" },
      { "<leader>gg", desc = "LazyGit (New Tab)" },
      { "<leader>gf", desc = "LazyGit Current File Dir" },
      { "<leader>gl", desc = "LazyGit (Alternative)" },
      
      -- GitHub PR and Issue Management
      { "<leader>go", desc = "Open Octo" },
      { "<leader>gp", group = "Pull Requests" },
      { "<leader>gpl", desc = "List PRs" },
      { "<leader>gpc", desc = "Create PR" },
      { "<leader>gpr", desc = "PR Checks" },
      { "<leader>gpd", desc = "PR Diff" },
      { "<leader>gpm", desc = "Merge PR" },
      { "<leader>gps", desc = "Checkout PR" },
      
      -- GitHub Issues
      { "<leader>gi", group = "Issues" },
      { "<leader>gil", desc = "List Issues" },
      { "<leader>gic", desc = "Create Issue" },
      
      -- GitHub Code Reviews
      { "<leader>gr", group = "Code Review" },
      { "<leader>grl", desc = "Start Review" },
      { "<leader>grs", desc = "Submit Review" },
      { "<leader>grc", desc = "Review Comments" },
      { "<leader>gra", desc = "Resume Review" },
      
      -- GitHub Telescope Integration
      { "<leader>gh", group = "GitHub Search" },
      { "<leader>ghp", desc = "Search Pull Requests" },
      { "<leader>ghi", desc = "Search Issues" },
      { "<leader>ghr", desc = "GitHub Actions" },
      { "<leader>ghg", desc = "GitHub Gists" },
      
      -- Git Worktree (for PR branches)
      { "<leader>gw", group = "Worktree" },
      { "<leader>gwc", desc = "Create Git Worktree" },
      { "<leader>gws", desc = "Switch Git Worktree" },
      
      -- GitSigns operations (hunk-level) - updated keybindings
      { "<leader>gs", desc = "Stage Hunk" },
      { "<leader>gS", desc = "Stage Buffer" },
      { "<leader>gu", desc = "Undo Stage Hunk" },
      { "<leader>gR", desc = "Reset Buffer" },
      { "<leader>ghr", desc = "Reset Hunk" },
      { "<leader>ghp", desc = "Preview Hunk" },
      { "<leader>gb", desc = "Blame Line" },
      { "<leader>gB", desc = "Toggle Line Blame" },
      { "<leader>gd", desc = "Diff This" },
      { "<leader>gD", desc = "Diff This ~" },
      { "<leader>gt", desc = "Toggle Git Signs" },
      { "<leader>gh", desc = "Toggle Line Highlight" },
      { "<leader>gwd", desc = "Toggle Word Diff" },
      { "]c", desc = "Next Git Hunk" },
      { "[c", desc = "Previous Git Hunk" },
      
      -- Diffview operations
      { "<leader>gv", desc = "Open Diffview" },
      { "<leader>gV", desc = "Close Diffview" },
      
      -- LSP operations
      { "<leader>l", group = "LSP" },
      { "gD", desc = "Go to Declaration" },
      { "gd", desc = "Go to Definition" },
      { "K", desc = "Hover Documentation" },
      { "gi", desc = "Go to Implementation" },
      { "<C-k>", desc = "Signature Help" },
      { "<leader>wa", desc = "Add Workspace Folder" },
      { "<leader>wr", desc = "Remove Workspace Folder" },
      { "<leader>wl", desc = "List Workspace Folders" },
      { "<leader>D", desc = "Type Definition" },
      { "<leader>rn", desc = "Rename Symbol" },
      { "<leader>ca", desc = "Code Actions" },
      { "gr", desc = "Find References" },
      { "<leader>f", desc = "Format Document" },
      
      -- Folding
      { "z", group = "Folding" },
      { "zR", desc = "Open All Folds" },
      { "zM", desc = "Close All Folds" },
      { "zr", desc = "Open Folds Except Kinds" },
      { "zm", desc = "Close Folds With" },
      { "zp", desc = "Peek Fold" },
      
      -- Navigation
      { "]", group = "Next" },
      { "[", group = "Previous" },
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Previous Reference" },
      { "]m", desc = "Next Function Start" },
      { "[m", desc = "Previous Function Start" },
      { "]M", desc = "Next Function End" },
      { "[M", desc = "Previous Function End" },
      
      -- Diagnostics
      { "<leader>d", group = "Diagnostics" },
      { "<leader>q", desc = "Quickfix List" },
      
      -- Text manipulation
      { "<leader>r", group = "Replace/Refactor" },
      
      -- Terminal
      { "<leader>t", group = "Terminal" },
      
      -- Settings/Config
      { "<leader>s", group = "Settings" },
    })
  end,
}
