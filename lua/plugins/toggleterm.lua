-- lua/plugins/toggleterm.lua - Persistent terminal splits
--
-- <C-`>       toggle bottom terminal (horizontal split, 15 lines)
-- <leader>tf  floating terminal
-- <leader>tv  vertical terminal (35% width)
--
-- Navigate out with <C-h/j/k/l> (already set globally in keymaps.lua)

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-`>",      mode = { "n", "t" }, desc = "Toggle bottom terminal" },
    { "<leader>tf", mode = { "n", "t" }, desc = "Float terminal" },
    { "<leader>tv", mode = { "n", "t" }, desc = "Vertical terminal" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then return 15 end
      if term.direction == "vertical"   then return math.floor(vim.o.columns * 0.35) end
    end,
    open_mapping    = [[<C-`>]],
    direction       = "horizontal",
    hide_numbers    = true,
    shade_terminals = false,
    start_in_insert = true,
    persist_size    = true,
    persist_mode    = true,
    close_on_exit   = true,
    auto_scroll     = true,
    float_opts = {
      border   = "curved",
      winblend = 3,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local Terminal = require("toggleterm.terminal").Terminal

    local float_term = Terminal:new({
      direction  = "float",
      hidden     = true,
      float_opts = {
        border   = "curved",
        width    = math.floor(vim.o.columns * 0.5),
        height   = math.floor(vim.o.lines   * 0.4),
        winblend = 3,
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        -- exit terminal mode first, then close the window
        vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<Esc>", [[<C-\><C-n>:close<CR>]], { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<Esc>", [[<cmd>close<CR>]],       { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q",     [[<cmd>close<CR>]],       { noremap = true, silent = true })
      end,
    })

    local vert_term = Terminal:new({ direction = "vertical", hidden = true })

    vim.keymap.set({ "n", "t" }, "<leader>tf", function() float_term:toggle() end, { desc = "Float terminal" })
    vim.keymap.set({ "n", "t" }, "<leader>tv", function() vert_term:toggle()  end, { desc = "Vertical terminal" })
  end,
}
