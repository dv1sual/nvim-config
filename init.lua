-- init.lua ─ Main configuration entry point
--
-- ➊  Sets a short “file-name-only” window title so WezTerm (or any terminal)
--    shows just the current buffer’s basename in its tab.
-- ➋  Everything else is exactly what you already had.
-- --------------------------------------------------------------------------- 
-- Font Settings
vim.opt.guifont = "BlexMono Nerd Font Mono:h12"
-- ---------------------------------------------------------------------------
-- Leader keys
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

-- ---------------------------------------------------------------------------
-- ➊  Short title for terminal tabs
vim.o.title       = true           -- enable terminal title reporting
vim.o.titlestring = 'nvim: %t'    -- WezTerm reads this to identify nvim tabs

-- ---------------------------------------------------------------------------
-- Core configuration
require('core.options')
require('core.keymaps')
require('core.claude')

-- ---------------------------------------------------------------------------
-- Plugin manager
require('core.lazy')
