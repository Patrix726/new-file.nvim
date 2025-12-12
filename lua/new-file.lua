-- main module file
local ui = require("new-file.ui")

---@class Config
---@field picker? "telescope" | "snacks" | nil Your picker option
---@field picker_opts? table
local config = {
  picker = nil,
  picker_opts = {},
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param opts Config?
function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
end

function M.open()
  if M.config.picker == "telescope" then
    ui.telescope_picker()
  elseif M.config.picker == "snacks" then
    ui.snacks_picker()
  else
    ui.ui_select()
  end
end

return M
