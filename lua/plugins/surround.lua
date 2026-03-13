-- lua/plugins/surround.lua
-- Add, change, or delete surrounding characters (quotes, brackets, tags, etc.)
--
-- Quick reference:
--   ysiw"   → surround word with "..."
--   ysiw(   → surround word with ( ... )
--   cs"'    → change surrounding " to '
--   ds"     → delete surrounding "
--   S"      → (visual mode) surround selection with "

return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup()
  end,
}
