## Previous Buffer

This is a neovim plugin which helps you to quickly jump back to the previous buffer which you had opened.
Unfortuntely neovim doesn't have this by default so i had to code this one up.

This uses cache invalidation and a stack to jump back to the previous buffer.When a buffer is opened it is added to the stack, whenever a buffer is re-opened the buffer is again pushed to the stack and the previous instance of the buffer on the stack is invalidated. So in essence we have a system which remembers buffer history such that we can navigate backwards easily.

## Installation

lazy.nvim

`
return {
	"kj-1809/previous-buffer.nvim",
	config = function()
		vim.keymap.set("n", "<leader>.", ":PreviousBuffer<CR>", { silent = true })
	end
}
`

## Usage

use the command `PreviousBuffer` or the keybind to jump back to the previous buffer.

