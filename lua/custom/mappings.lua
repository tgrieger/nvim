---@type MappingsTable
local M = {}

M.general = {
  n = {
    [" "] = { "<nop>", "disable space"}
  },
  i = {
    ["<C-h>"] = { "<C-w>", "Delete whole word" },
  }
}

-- more keybinds!

return M
