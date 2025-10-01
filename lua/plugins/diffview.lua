-- lua/plugins/diffview.lua - Advanced diff viewing

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
    { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
    -- PR review specific commands
    { "<leader>gpr", function()
        -- Show diff for the current PR branch against main/master
        local main_branch = "main"
        -- Try to detect the default branch
        local handle = io.popen("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          if result and result:match("refs/remotes/origin/(.+)") then
            main_branch = result:match("refs/remotes/origin/(.+)"):gsub("\n", "")
          end
        end
        vim.cmd("DiffviewOpen origin/" .. main_branch .. "...HEAD")
      end, desc = "PR Diff (vs main)" },
    { "<leader>gpc", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Compare with Previous Commit" },
    { "<leader>gpf", "<cmd>DiffviewFileHistory --follow %<cr>", desc = "PR File History" },
  },
  config = function()
    require("diffview").setup({
      diff_binaries = false,
      enhanced_diff_hl = false,
      git_cmd = { "git" },
      use_icons = true,
      show_help_hints = true,
      watch_index = true,
      
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      
      view = {
        default = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true,
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_horizontal",
          winbar_info = false,
        },
      },
      
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "only_folded",
        },
        win_config = {
          position = "left",
          width = 35,
          win_opts = {}
        },
      },
      
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
        },
        win_config = {
          position = "bottom",
          height = 16,
          win_opts = {}
        },
      },
      
      commit_log_panel = {
        win_config = {
          win_opts = {},
        }
      },
      
      default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      
      hooks = {},
      
      keymaps = {
        disable_defaults = false,
        view = {
          {
            "n",
            "<tab>",
            function()
              require("diffview.actions").select_next_entry()
            end,
            { desc = "Next file" }
          },
          {
            "n", 
            "<s-tab>",
            function()
              require("diffview.actions").select_prev_entry()
            end,
            { desc = "Previous file" }
          },
          {
            "n",
            "gf",
            function()
              require("diffview.actions").goto_file()
            end,
            { desc = "Go to file" }
          },
          {
            "n",
            "<leader>e",
            function()
              require("diffview.actions").focus_files()
            end,
            { desc = "Focus files" }
          },
          {
            "n",
            "<leader>b",
            function()
              require("diffview.actions").toggle_files()
            end,
            { desc = "Toggle files" }
          },
        },
        diff1 = {
          { "n", "g?", function() require("diffview.actions").help("view") end, { desc = "Help" } },
        },
        diff2 = {
          { "n", "g?", function() require("diffview.actions").help("view") end, { desc = "Help" } },
        },
        diff3 = {
          { { "n", "x" }, "2do", { desc = "Obtain from OURS" } },
          { { "n", "x" }, "3do", { desc = "Obtain from THEIRS" } },
          { "n", "g?", function() require("diffview.actions").help("view") end, { desc = "Help" } },
        },
        diff4 = {
          { { "n", "x" }, "1do", { desc = "Obtain from BASE" } },
          { { "n", "x" }, "2do", { desc = "Obtain from OURS" } },
          { { "n", "x" }, "3do", { desc = "Obtain from THEIRS" } },
          { "n", "g?", function() require("diffview.actions").help("view") end, { desc = "Help" } },
        },
        file_panel = {
          { "n", "j", function() require("diffview.actions").next_entry() end, { desc = "Next entry" } },
          { "n", "k", function() require("diffview.actions").prev_entry() end, { desc = "Previous entry" } },
          { "n", "<cr>", function() require("diffview.actions").select_entry() end, { desc = "Select entry" } },
          { "n", "o", function() require("diffview.actions").select_entry() end, { desc = "Select entry" } },
          { "n", "l", function() require("diffview.actions").select_entry() end, { desc = "Select entry" } },
          { "n", "-", function() require("diffview.actions").toggle_stage_entry() end, { desc = "Stage/unstage" } },
          { "n", "S", function() require("diffview.actions").stage_all() end, { desc = "Stage all" } },
          { "n", "U", function() require("diffview.actions").unstage_all() end, { desc = "Unstage all" } },
          { "n", "X", function() require("diffview.actions").restore_entry() end, { desc = "Restore entry" } },
          { "n", "R", function() require("diffview.actions").refresh_files() end, { desc = "Refresh" } },
          { "n", "<tab>", function() require("diffview.actions").select_next_entry() end, { desc = "Next file" } },
          { "n", "<s-tab>", function() require("diffview.actions").select_prev_entry() end, { desc = "Previous file" } },
          { "n", "gf", function() require("diffview.actions").goto_file() end, { desc = "Go to file" } },
          { "n", "<leader>e", function() require("diffview.actions").focus_files() end, { desc = "Focus files" } },
          { "n", "<leader>b", function() require("diffview.actions").toggle_files() end, { desc = "Toggle files" } },
          { "n", "g?", function() require("diffview.actions").help("file_panel") end, { desc = "Help" } },
        },
        file_history_panel = {
          { "n", "g!", function() require("diffview.actions").options() end, { desc = "Options" } },
          { "n", "y", function() require("diffview.actions").copy_hash() end, { desc = "Copy hash" } },
          { "n", "L", function() require("diffview.actions").open_commit_log() end, { desc = "Commit details" } },
          { "n", "j", function() require("diffview.actions").next_entry() end, { desc = "Next entry" } },
          { "n", "k", function() require("diffview.actions").prev_entry() end, { desc = "Previous entry" } },
          { "n", "<cr>", function() require("diffview.actions").select_entry() end, { desc = "Select entry" } },
          { "n", "o", function() require("diffview.actions").select_entry() end, { desc = "Select entry" } },
          { "n", "<tab>", function() require("diffview.actions").select_next_entry() end, { desc = "Next file" } },
          { "n", "<s-tab>", function() require("diffview.actions").select_prev_entry() end, { desc = "Previous file" } },
          { "n", "gf", function() require("diffview.actions").goto_file() end, { desc = "Go to file" } },
          { "n", "<leader>e", function() require("diffview.actions").focus_files() end, { desc = "Focus files" } },
          { "n", "<leader>b", function() require("diffview.actions").toggle_files() end, { desc = "Toggle files" } },
          { "n", "g?", function() require("diffview.actions").help("file_history_panel") end, { desc = "Help" } },
        },
        option_panel = {
          { "n", "<tab>", function() require("diffview.actions").select_entry() end, { desc = "Change option" } },
          { "n", "q", function() require("diffview.actions").close() end, { desc = "Close" } },
          { "n", "g?", function() require("diffview.actions").help("option_panel") end, { desc = "Help" } },
        },
        help_panel = {
          { "n", "q", function() require("diffview.actions").close() end, { desc = "Close" } },
          { "n", "<esc>", function() require("diffview.actions").close() end, { desc = "Close" } },
        },
      },
    })
  end,
}