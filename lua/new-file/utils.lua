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
  local input = vim.fn.input("Enter pathname inside " .. folder .. ": ")
  if not input or input == "" then
    return
  end
  local path = folder .. "/" .. input
  local is_dir = path:sub(-1) == "/"
  create_path(path)
  print("Created: " .. path)
  if not is_dir then
    vim.cmd("edit " .. vim.fn.fnameescape(path))
  end
end

function M.detect_picker()
  local ok, _ = pcall(require, "telescope")
  if ok then
    return "telescope"
  end

  local ok2, _ = pcall(require, "snacks")
  if ok2 then
    return "snacks"
  end

  return nil
end

return M
