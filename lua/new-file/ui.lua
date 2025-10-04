local utils = require("new-file.utils")
local M = {}

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

-- snacks adapter (example stub, you’d hook into their picker API)
function M.snacks_picker()
  require("snacks").picker.pick({
    title = "Select folder",
    items = vim.fn.systemlist("fd --type=d --hidden --exclude .git"),
    on_select = function(item)
      Snacks.notify("Been here")
      utils.create_in_folder(item)
    end,
  })
end

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

return M
