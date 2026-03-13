-- lua/core/lazy.lua - Lazy package manager setup

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- Import plugin configurations
  { import = "plugins" },
}, {
  -- Lazy.nvim configuration
  defaults = {
    lazy = true,  -- plugins without explicit events/keys/cmds are lazy by default
    version = false, -- always use the latest git commit
  },
  install = {
    missing = true, -- install missing plugins on startup
    colorscheme = { "nightfox" }, -- try to load one of these colorschemes when starting an installation during startup
  },
  checker = {
    enabled = false, -- don't check for updates on every startup (run :Lazy update manually)
  },
  change_detection = {
    enabled = true,
    notify = false, -- don't notify when config file changes
  },
  ui = {
    border = "rounded",
  },
})