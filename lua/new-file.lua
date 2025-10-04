-- main module file
local ui = require("new-file.ui")

---@class Config
---@field picker string Your config option
local config = {
  picker = "telescope",
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param opts Config?
function M.setup(opts)
  M.config = vim.tbl_extend("force", M.config, opts or {})
end

function M.run()
  if M.config.picker == "telescope" then
    ui.telescope_picker()
  elseif M.config.picker == "snacks" then
    ui.snacks_picker()
  elseif M.config.picker == "fzf" then
    ui.fzf_picker()
  else
    error("Unsupported picker: " .. tostring(M.config.picker))
  end
end

return M
