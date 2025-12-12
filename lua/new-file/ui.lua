local utils = require("new-file.utils")
local M = {}

-- Use telescope for selecting folder
function M.telescope_picker()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local dirs = vim.fn.systemlist("fd --type=d --hidden --exclude .git")
  local items = { "./" }

  for _, item in ipairs(dirs) do
    table.insert(items, item)
  end

  pickers
    .new({}, {
      prompt_title = "Select folder",
      finder = finders.new_table(items),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        local function select()
          local entry = action_state.get_selected_entry()
          actions.close(_)
          utils.create_in_folder(entry[1])
        end
        map("i", "<CR>", select)
        map("n", "<CR>", select)
        return true
      end,
    })
    :find()
end

-- Use snacks_picker for selecting folder
function M.snacks_picker()
  -- TODO: Add a way to configure the snacks layout
  local dirs = vim.fn.systemlist("fd --type=d --hidden --exclude .git")
  local items = { { text = "/", value = "." } }

  for _, item in ipairs(dirs) do
    table.insert(items, { text = item, value = item })
  end

  require("snacks").picker.pick({
    title = "Select folder",
    format = "text",
    -- layout = "select",
    items = items,
    layout = { preset = "vscode", hidden = { "preview" } },
    confirm = function(picker, item)
      picker:close()
      if item then
        vim.notify("Selected " .. item.text)
        utils.create_in_folder(item.value)
      end
    end,
  })
end

-- Use builtin ui-select for selecting folder
function M.ui_select()
  local dirs = vim.fn.systemlist("fd --type=d --hidden --exclude .git")
  local items = { { text = "/", value = "." } }

  for _, item in ipairs(dirs) do
    table.insert(items, { text = item, value = item })
  end

  vim.ui.select(items, {
    prompt = "Select folder",
    format_item = function(item)
      return item.text
    end,
  }, function(item)
    if item then
      utils.create_in_folder(item.value)
    end
  end)
end

return M
