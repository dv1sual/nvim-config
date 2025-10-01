-- lua/plugins/github.lua - GitHub integration with octo.nvim for PR reviews

return {
  -- Main GitHub integration plugin
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    event = { { event = "BufReadCmd", pattern = "octo://*" } },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>go", "<cmd>Octo<cr>", desc = "Open Octo" },
      { "<leader>gpl", "<cmd>Octo pr list<cr>", desc = "List PRs" },
      { "<leader>gpc", "<cmd>Octo pr create<cr>", desc = "Create PR" },
      { "<leader>gpr", "<cmd>Octo pr checks<cr>", desc = "PR Checks" },
      { "<leader>gpd", "<cmd>Octo pr diff<cr>", desc = "PR Diff" },
      { "<leader>gpm", "<cmd>Octo pr merge<cr>", desc = "Merge PR" },
      { "<leader>gps", "<cmd>Octo pr checkout<cr>", desc = "Checkout PR" },
      { "<leader>gil", "<cmd>Octo issue list<cr>", desc = "List Issues" },
      { "<leader>gic", "<cmd>Octo issue create<cr>", desc = "Create Issue" },
      { "<leader>grl", "<cmd>Octo review start<cr>", desc = "Start Review" },
      { "<leader>grs", "<cmd>Octo review submit<cr>", desc = "Submit Review" },
      { "<leader>grc", "<cmd>Octo review comments<cr>", desc = "Review Comments" },
      { "<leader>gra", "<cmd>Octo review resume<cr>", desc = "Resume Review" },
    },
    opts = {
      -- GitHub Enterprise support (if needed)
      -- github_hostname = "github.company.com",
      
      -- Authentication method
      use_local_fs = false, -- Set to true if you prefer file-based auth
      
      -- Default branch
      default_remote = {"upstream", "origin"},
      
      -- Default merge method
      default_merge_method = "squash", -- or "merge", "rebase"
      
      -- SSH remote handling
      ssh_aliases = {},
      
      -- Reaction viewer
      reaction_viewer_hint_icon = "",
      user_icon = " ",
      timeline_marker = "",
      timeline_indent = "2",
      
      -- UI configuration
      ui = {
        use_signcolumn = true,
      },
      
      -- Colors and highlights
      colors = {
        white = "#ffffff",
        grey = "#2A354C",
        black = "#000000",
        red = "#fdb8c0",
        dark_red = "#da3633",
        green = "#acf2bd",
        dark_green = "#238636",
        yellow = "#d3c846",
        dark_yellow = "#735c0f",
        blue = "#58A6FF",
        dark_blue = "#0969da",
        purple = "#bc8cff",
        dark_purple = "#8250df",
      },
      
      -- File panel configuration
      file_panel = {
        size = 10,           -- Height of the file panel
        use_icons = true,    -- Use web devicons in the file panel
      },
      
      -- Mappings for octo buffers
      mappings = {
        issue = {
          close_issue = { lhs = "<space>ic", desc = "Close issue" },
          reopen_issue = { lhs = "<space>io", desc = "Reopen issue" },
          list_issues = { lhs = "<space>il", desc = "List open issues on same repo" },
          reload = { lhs = "<C-r>", desc = "Reload issue" },
          open_in_browser = { lhs = "<C-b>", desc = "Open issue in browser" },
          copy_url = { lhs = "<C-y>", desc = "Copy URL to system clipboard" },
          add_assignee = { lhs = "<space>aa", desc = "Add assignee" },
          remove_assignee = { lhs = "<space>ad", desc = "Remove assignee" },
          create_label = { lhs = "<space>lc", desc = "Create label" },
          add_label = { lhs = "<space>la", desc = "Add label" },
          remove_label = { lhs = "<space>ld", desc = "Remove label" },
          goto_issue = { lhs = "<space>gi", desc = "Navigate to a local repo issue" },
          add_comment = { lhs = "<space>ca", desc = "Add comment" },
          delete_comment = { lhs = "<space>cd", desc = "Delete comment" },
          next_comment = { lhs = "}c", desc = "Go to next comment" },
          prev_comment = { lhs = "{c", desc = "Go to previous comment" },
          react_hooray = { lhs = "<space>rp", desc = "Add/remove 🎉 reaction" },
          react_heart = { lhs = "<space>rh", desc = "Add/remove ❤️ reaction" },
          react_eyes = { lhs = "<space>re", desc = "Add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<space>r+", desc = "Add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<space>r-", desc = "Add/remove 👎 reaction" },
          react_rocket = { lhs = "<space>rr", desc = "Add/remove 🚀 reaction" },
          react_laugh = { lhs = "<space>rl", desc = "Add/remove 😄 reaction" },
          react_confused = { lhs = "<space>rc", desc = "Add/remove 😕 reaction" },
        },
        pull_request = {
          checkout_pr = { lhs = "<space>po", desc = "Checkout PR" },
          merge_pr = { lhs = "<space>pm", desc = "Merge commit PR" },
          squash_and_merge_pr = { lhs = "<space>psm", desc = "Squash and merge PR" },
          rebase_and_merge_pr = { lhs = "<space>prm", desc = "Rebase and merge PR" },
          list_commits = { lhs = "<space>pc", desc = "List PR commits" },
          list_changed_files = { lhs = "<space>pf", desc = "List PR changed files" },
          show_pr_diff = { lhs = "<space>pd", desc = "Show PR diff" },
          add_reviewer = { lhs = "<space>va", desc = "Add reviewer" },
          remove_reviewer = { lhs = "<space>vd", desc = "Remove reviewer" },
          close_issue = { lhs = "<space>ic", desc = "Close PR" },
          reopen_issue = { lhs = "<space>io", desc = "Reopen PR" },
          list_issues = { lhs = "<space>il", desc = "List open issues on same repo" },
          reload = { lhs = "<C-r>", desc = "Reload PR" },
          open_in_browser = { lhs = "<C-b>", desc = "Open PR in browser" },
          copy_url = { lhs = "<C-y>", desc = "Copy URL to system clipboard" },
          goto_file = { lhs = "gf", desc = "Go to file" },
          add_assignee = { lhs = "<space>aa", desc = "Add assignee" },
          remove_assignee = { lhs = "<space>ad", desc = "Remove assignee" },
          create_label = { lhs = "<space>lc", desc = "Create label" },
          add_label = { lhs = "<space>la", desc = "Add label" },
          remove_label = { lhs = "<space>ld", desc = "Remove label" },
          goto_issue = { lhs = "<space>gi", desc = "Navigate to a local repo issue" },
          add_comment = { lhs = "<space>ca", desc = "Add comment" },
          delete_comment = { lhs = "<space>cd", desc = "Delete comment" },
          next_comment = { lhs = "}c", desc = "Go to next comment" },
          prev_comment = { lhs = "{c", desc = "Go to previous comment" },
          react_hooray = { lhs = "<space>rp", desc = "Add/remove 🎉 reaction" },
          react_heart = { lhs = "<space>rh", desc = "Add/remove ❤️ reaction" },
          react_eyes = { lhs = "<space>re", desc = "Add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<space>r+", desc = "Add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<space>r-", desc = "Add/remove 👎 reaction" },
          react_rocket = { lhs = "<space>rr", desc = "Add/remove 🚀 reaction" },
          react_laugh = { lhs = "<space>rl", desc = "Add/remove 😄 reaction" },
          react_confused = { lhs = "<space>rc", desc = "Add/remove 😕 reaction" },
        },
        review_thread = {
          goto_issue = { lhs = "<space>gi", desc = "Navigate to a local repo issue" },
          add_comment = { lhs = "<space>ca", desc = "Add comment" },
          add_suggestion = { lhs = "<space>sa", desc = "Add suggestion" },
          delete_comment = { lhs = "<space>cd", desc = "Delete comment" },
          next_comment = { lhs = "}c", desc = "Go to next comment" },
          prev_comment = { lhs = "{c", desc = "Go to previous comment" },
          select_next_entry = { lhs = "]q", desc = "Move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "Move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
          react_hooray = { lhs = "<space>rp", desc = "Add/remove 🎉 reaction" },
          react_heart = { lhs = "<space>rh", desc = "Add/remove ❤️ reaction" },
          react_eyes = { lhs = "<space>re", desc = "Add/remove 👀 reaction" },
          react_thumbs_up = { lhs = "<space>r+", desc = "Add/remove 👍 reaction" },
          react_thumbs_down = { lhs = "<space>r-", desc = "Add/remove 👎 reaction" },
          react_rocket = { lhs = "<space>rr", desc = "Add/remove 🚀 reaction" },
          react_laugh = { lhs = "<space>rl", desc = "Add/remove 😄 reaction" },
          react_confused = { lhs = "<space>rc", desc = "Add/remove 😕 reaction" },
        },
        submit_win = {
          approve_review = { lhs = "<C-a>", desc = "Approve review" },
          comment_review = { lhs = "<C-m>", desc = "Comment review" },
          request_changes = { lhs = "<C-r>", desc = "Request changes review" },
          close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
        },
        review_diff = {
          submit_review = { lhs = "<leader>vs", desc = "Submit review" },
          discard_review = { lhs = "<leader>vd", desc = "Discard review" },
          add_review_comment = { lhs = "<space>ca", desc = "Add a new review comment" },
          add_review_suggestion = { lhs = "<space>sa", desc = "Add a new review suggestion" },
          focus_files = { lhs = "<leader>e", desc = "Move focus to changed file panel" },
          toggle_files = { lhs = "<leader>b", desc = "Hide/show changed files panel" },
          next_thread = { lhs = "}t", desc = "Move to next thread" },
          prev_thread = { lhs = "{t", desc = "Move to previous thread" },
          select_next_entry = { lhs = "]q", desc = "Move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "Move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
          toggle_viewed = { lhs = "<leader><space>", desc = "Toggle viewer viewed state" },
          goto_file = { lhs = "gf", desc = "Go to file" },
        },
        file_panel = {
          next_entry = { lhs = "j", desc = "Move to next changed file" },
          prev_entry = { lhs = "k", desc = "Move to previous changed file" },
          select_entry = { lhs = "<cr>", desc = "Show selected changed file diffs" },
          refresh_files = { lhs = "R", desc = "Refresh changed files panel" },
          focus_files = { lhs = "<leader>e", desc = "Move focus to changed file panel" },
          toggle_files = { lhs = "<leader>b", desc = "Hide/show changed files panel" },
          select_next_entry = { lhs = "]q", desc = "Move to previous changed file" },
          select_prev_entry = { lhs = "[q", desc = "Move to next changed file" },
          close_review_tab = { lhs = "<C-c>", desc = "Close review tab" },
          toggle_viewed = { lhs = "<leader><space>", desc = "Toggle viewer viewed state" },
        },
      },
      
      -- Review settings
      reviews = {
        auto_show_threads = true,
      },
      
      -- Comment settings
      comment = {
        style = "icon", -- or "none"
        icon = "",
        add_reviewer = {
          use_telescope = true,
        },
      },
      
      -- Search settings
      search = {
        limit = 50,
      },
    },
    config = function(_, opts)
      require("octo").setup(opts)
      
      -- Load telescope extension
      require('telescope').load_extension('octo')
      
      -- Custom highlights to match your nightfox theme
      vim.api.nvim_set_hl(0, "OctoEditable", { bg = "#394b70", fg = "#c0caf5" })
      vim.api.nvim_set_hl(0, "OctoBubble", { bg = "#283457", fg = "#a9b1d6" })
      vim.api.nvim_set_hl(0, "OctoBubbleGreen", { bg = "#1e2817", fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "OctoBubbleRed", { bg = "#2e1f1f", fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "OctoBubbleBlue", { bg = "#192b3d", fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "OctoUser", { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "OctoTimelineItemHeading", { fg = "#bb9af7", bold = true })
      vim.api.nvim_set_hl(0, "OctoDetailsLabel", { fg = "#565f89", bold = true })
      vim.api.nvim_set_hl(0, "OctoMissingDetails", { fg = "#565f89", italic = true })
      vim.api.nvim_set_hl(0, "OctoPullAdditions", { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "OctoPullDeletions", { fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "OctoPullModifications", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "OctoViewer", { fg = "#bb9af7" })
      vim.api.nvim_set_hl(0, "OctoGreenFloat", { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "OctoRedFloat", { fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "OctoYellowFloat", { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "OctoBlueFloat", { fg = "#7aa2f7" })
      vim.api.nvim_set_hl(0, "OctoPurpleFloat", { fg = "#bb9af7" })
      vim.api.nvim_set_hl(0, "OctoIssueTitle", { fg = "#c0caf5", bold = true })
      vim.api.nvim_set_hl(0, "OctoPullTitle", { fg = "#c0caf5", bold = true })
    end,
  },

  -- GitHub-specific telescope pickers
  {
    "nvim-telescope/telescope-github.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -- Load the extension
      require('telescope').load_extension('gh')
    end,
    keys = {
      { "<leader>ghp", "<cmd>Telescope gh pull_request<cr>", desc = "GitHub Pull Requests" },
      { "<leader>ghi", "<cmd>Telescope gh issues<cr>", desc = "GitHub Issues" },
      { "<leader>ghr", "<cmd>Telescope gh run<cr>", desc = "GitHub Actions" },
      { "<leader>ghg", "<cmd>Telescope gh gist<cr>", desc = "GitHub Gists" },
    },
  },

  -- Enhanced git worktree support for PR branches
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("git-worktree").setup({
        change_directory_command = "cd",
        update_on_change = true,
        update_on_change_command = "e .",
        clearjumps_on_change = true,
        auto_checkout = false,
      })
      
      -- Load telescope extension
      require('telescope').load_extension('git_worktree')
    end,
    keys = {
      {
        "<leader>gwc",
        function() 
          require('telescope').extensions.git_worktree.create_git_worktree()
        end,
        desc = "Create Git Worktree"
      },
      {
        "<leader>gws",
        function() 
          require('telescope').extensions.git_worktree.git_worktrees()
        end,
        desc = "Switch Git Worktree"
      },
    },
  },
}