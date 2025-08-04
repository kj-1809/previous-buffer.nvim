# previous-buffer.nvim

A simple Neovim plugin to quickly jump back to the previously opened buffer.

Neovim does not have built-in support for jumping back to the last buffer you were editing. This plugin implements a buffer history stack with cache invalidation to enable easy backward navigation through your buffer history.

---

## Features

- Maintains a stack of recently opened buffers
- Invalidates old entries when buffers are reopened
- Allows quick jumping to the previous buffer with a command or keybind

---

## Installation

Use [lazy.nvim](https://github.com/folke/lazy.nvim) to install the plugin:

```lua
return {
  "kj-1809/previous-buffer.nvim",
  config = function()
    vim.keymap.set("n", "<leader>.", ":PreviousBuffer<CR>", { silent = true })
  end,
}
```
## Usage

Use the command `PreviousBuffer` or the keybind to jump back to the previous buffer.
