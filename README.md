# new-file.nvim

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/ellisonleao/nvim-plugin-template/lint-test.yml?branch=main&style=for-the-badge)
![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)

> **BETA**: This plugin is currently in beta. Please report any issues you encounter.

A Neovim plugin for creating new files and directories with an interactive picker interface.

## Acknowledgments

This plugin is inspired by [vscode-advanced-new-file](https://github.com/patbenatar/vscode-advanced-new-file), a similar plugin developed for VSCode.

## Installation

### lazy.nvim

```lua
{
  "patrix726/new-file.nvim",
  opts = {},
  keys = {
    {
      '<leader>cp',
      function()
        require('new-file').open()
      end,
      mode = 'n',
      { desc = '[C]reate new file/folder/[P]ath in selected directory' },
    },
  },
}
```

### packer.nvim

```lua
use {
  "patrix726/new-file.nvim",
  config = function()
    require("new-file").setup({})
    vim.keymap.set('n', '<leader>cp', function()
      require('new-file').open()
    end, { desc = '[C]reate new file/folder/[P]ath in selected directory' })
  end,
}
```

## Prerequisites

- [fd](https://github.com/sharkdp/fd) - A simple, fast and user-friendly alternative to find

## Usage

Call `:lua require("new-file").open()` to open the folder picker. Select a directory, then enter the pathname for the new file or directory you want to create.

## Configuration

```lua
require("new-file").setup({
  picker = "telescope", -- "telescope" | "snacks" | nil (default | uses vim.ui.select)
})
```

### Supported Pickers

- **telescope**: Uses Telescope for folder selection
- **snacks**: Uses Snacks picker
- **vim.ui.select** (default): Uses Neovim's built-in UI select

The plugin automatically detects available pickers if none is specified.

## Features

- Interactive folder selection using your preferred picker
- Create files and directories
- Automatic file opening after creation
- Support for multiple picker backends

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure your code follows the existing style and includes tests for new functionality.
