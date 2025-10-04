local M = {}

-- utility to create files/folders
local function create_path(path)
  local is_dir = path:sub(-1) == "/"
  if is_dir then
    vim.fn.mkdir(path, "p")
  else
    vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
    local fd = io.open(path, "w")
    if fd then
      fd:close()
    end
  end
end

-- core logic once folder is chosen
function M.create_in_folder(folder)
  vim.ui.input({ prompt = "Enter file/folder name inside " .. folder .. ": " }, function(input)
    if not input or input == "" then
      return
    end
    local path = folder .. "/" .. input
    create_path(path)
    print("Created: " .. path)
  end)
end

return M
