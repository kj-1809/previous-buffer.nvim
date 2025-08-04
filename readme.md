## Previous Buffer

This is a neovim plugin which helps you to quickly jump back to the previous buffer which you had opened.
Unfortuntely neovim doesn't have this by default so i had to code this one up.

This uses cache invalidation and a stack to jump back to the previous buffer.When a buffer is opened it is added to the stack, whenever a buffer is re-opened the buffer is again pushed to the stack and the previous instance of the buffer on the stack is invalidated. So in essence we have a system which remembers buffer history such that we can navigate backwards easily.

## Installation
Download source and link it in your nvim config.

In your nvim config create a new file under the plugins directory and name it whatever and add this snippet.

use `{
{ dir = "path/to/the/source_code"}
}`

## Usage

use the command `PreviousBuffer` to jump back to the previous buffer.

you should probably bind a key to this command.

