-- lua/core/options.lua - Neovim options and settings

local opt = vim.opt

-- Font configuration (mainly for GUI versions)
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
elseif vim.g.fvim then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
end

-- Line numbers
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers

-- Mouse
opt.mouse = 'a'           -- Enable mouse support

-- Search
opt.ignorecase = true     -- Ignore case in search
opt.smartcase = true      -- Override ignorecase if search contains capitals
opt.hlsearch = false      -- Don't highlight search results

-- Text rendering
opt.wrap = false          -- Don't wrap lines
opt.breakindent = true    -- Enable break indent
opt.scrolloff = 10        -- Minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8     -- Minimal number of screen columns to keep to the left and right of the cursor

-- Splits
opt.splitright = true     -- Configure how new splits should be opened
opt.splitbelow = true

-- Undo
opt.undofile = true       -- Save undo history

-- Interface
opt.signcolumn = "yes"    -- Always show sign column
opt.cursorline = true     -- Show which line your cursor is on
opt.termguicolors = true  -- Enable 24-bit RGB colors

-- Timing
opt.updatetime = 250      -- Decrease update time
opt.timeoutlen = 300      -- Decrease mapped sequence wait time

-- Command line
opt.inccommand = "split"  -- Preview substitutions live, as you type!

-- Indentation
opt.tabstop = 4           -- Number of spaces tabs count for
opt.shiftwidth = 4        -- Size of an indent
opt.expandtab = true      -- Use spaces instead of tabs
opt.smartindent = true    -- Insert indents automatically

-- File handling
opt.backup = false        -- Don't store backup while overwriting the file
opt.writebackup = false   -- Don't store backup while overwriting the file
opt.swapfile = false      -- Don't store swapfile

-- Completion
opt.completeopt = "menu,menuone,noselect" -- Set completeopt to have a better completion experience

-- Folding (if you want to enable it later)
-- opt.foldmethod = "expr"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldenable = false