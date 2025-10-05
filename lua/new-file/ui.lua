local utils = require("new-file.utils")
local M = {}

-- TODO: Find a way to add cwd into the list
-- telescope adapter
function M.telescope_picker()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  pickers
    .new({}, {
      prompt_title = "Select folder",
      finder = finders.new_oneshot_job({ "fd", "--type=d", "--hidden", "--exclude", ".git" }, {}),
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

-- TODO: Function probably not functional
-- snacks adapter (example stub, you’d hook into their picker API)
function M.snacks_picker()
  local dirs = vim.fn.systemlist("fd --type=d --hidden --exclude .git")
  local items = vim.tbl_map(function(dir)
    return { text = dir }
  end, dirs)
  require("snacks").picker.pick({
    title = "Select folder",
    items = items,
    layout = { preset = "ivy" },
    on_select = function(item)
      Snacks.notify("Selected item")
      utils.create_in_folder(item.text)
    end,
  })
end

-- TODO: Function probably not functional
-- fzf-lua adapter
function M.fzf_picker()
  require("fzf-lua").fzf_exec("fd --type=d --hidden --exclude .git", {
    prompt = "Select folder> ",
    actions = {
      ["default"] = function(selected)
        utils.create_in_folder(selected[1])
      end,
    },
  })
end

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
