# rspec-focus

With this package you can:
- add `focus: true` tag to nearest RSpec test (moving upwards from cursor)
- clear all `focus: true` tags from current buffer

## Keymaps

`ctrl-alt-cmd-t` - Add `focus: true` tag to closest `it`, `describe`,
  `context`, `feature`, or `scenario` block.

`ctrl-alt-cmd-z` - Clear all `focus: true` tags from current open buffer.

### Customize Keymaps

If you'd like to change the keymaps, add the following entries to your local
  keymap file, changing the triggers to whatever you'd like:

    'ctrl-alt-cmd-t': 'rspec-focus:add'
    'ctrl-alt-cmd-z': 'rspec-focus:clear'
