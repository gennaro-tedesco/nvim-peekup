<img src="img/logo.png" width="200" height="200" />
# nvim-peekup
Finally vim registers made easy and fun! No more headaches with cumbersome keystrokes `"<register>p`, no more forgetting where the yanked text is: peek into the vim registers in floating window and pick up the text you want with `nvim-peekup`!

![](img/screenshot.png)

## Installation
Install it using your favourite plugin manager; for instance if you are using vim-plug
```
Plug 'gennaro-tedesco/nvim-peekup'
```
We recommend to use the latest neovim [nightly build](https://github.com/neovim/neovim/releases/tag/nightly), as some lua options may not work otherwise.

## Usage
Open the peekup window with the default keymapping `""`. Scroll and browse the list of registers ordered by type and select the register you want by simply pressing the corresponding character (letter or number, no need to prepend `"`): you receive visual confirmation for your choice and the text is copied into the default register. The peekup window automatically closes and you can now easily put (`p`) your yanked text anywhere you want.

`<Esc>` to manually close the window otherwise.

![](img/demo.gif)

Default commands

| key             | description
|:--------------- |:-------------
|""               | open peekup window
|`<Esc>`          | close peekup window
|any character    | select and copy text from the corresponding " register
|`<C-j>`, `<C-k>` | scroll the list up and down
|`<Up>`, `<Down>` | move to next registers type

Notice that since characters keystrokes copy the text from the corresponding register, the peekup window does not obey the standard vim motion commands. Arrow keys move among registers sections (they can also use the corresponding marks `'n, 'l, 's`).

To change default mapping to open the peekup window simply specify the right hand side of
```
let g:peekup_open = '<leader>"'
```
If you want to directly paste before or after the current cursor position (without having to issue `p` after the selection) simply specify values for the options
```
let g:peekup_paste_before = '<leader>P'
let g:peekup_paste_after = '<leader>p'
```

Exposed interfaces

| option                   | method                       | description
|:------------------------ |:---------------------------- |:----------------
|g:peekup\_open            | `<Plug>PeekupOpen`           | open peekup window and interact
|g:peekup\_paste\_before   | `<Plug>PeekupPasteBefore`    | directly paste before cursor upon selection
|g:peekup\_paste\_after    | `<Plug>PeekupPasteAfter`     | directly paste after cursor upon selection

see also `:help peekup-usage`.

## Features in short
- peekup floating window with registers content
- visual confirmation of selected text
- peekup closes automatically, put (`p`) the yanked text anywhere
- fully customisable layout and behaviour

## Customisation
The look and the behaviour of the registers floating window is fully customisable. In order to do so simply override the [dictionary configuration entries](https://github.com/gennaro-tedesco/nvim-peekup/blob/master/lua/nvim-peekup/config.lua) specifying the below in your nvim configurations (init.vim or any other option file being sourced at start-up), say
```
" geometry configuration
lua require('nvim-peekup.config').geometry["height"] = 0.8
lua require('nvim-peekup.config').geometry["title"] = 'An awesome window title'
lua require('nvim-peekup.config').geometry["wrap"] = false
```
`width` and `height` are to be expressed as ratios of the entire window size, therefore 0 < x < 1.
```
" behaviour of the peekup window on keystroke
lua require('nvim-peekup.config').on_keystroke["delay"] = '300ms'
lua require('nvim-peekup.config').on_keystroke["autoclose"] = false
lua require('nvim-peekup.config').on_keystroke["paste_reg"] = '"'
```
`delay` expresses the delay before the peekup window closes automatically, after selecting the register. Obviously, `autoclose` set to false prevents such behaviour (and the user must close the window manually).
`delay` can be set to the empty string to not delay at all, i.e.:
```
lua require('nvim-peekup.config').on_keystroke["delay"] = ''
```

The selected paste goes into the default register `*`: change accordingly if needed.


## Help tags
Access the documentation with `:h nvim-peekup`.

## Unit tests
We make use of the busted framework for unit tests; run them with
```
busted -C lua
```

## Feedback
If you find this plugin useful consider awarding it a ⭐, it is a great way to give feedback! Otherwise, any additional suggestions or merge request is warmly welcome!

This plugin was inspired by [vim-peekaboo](https://github.com/junegunn/vim-peekaboo), which in addition also allows to paste in insert mode. However, `nvim-peekup` offers a fresh interactive and visual experience with registers and, not that it matters, is in average  more than 4 times faster at start-up:
```
nvim --startuptime start.log -c quit && grep "peekup|peekaboo" start.log
elapsed
000.051  000.051: sourcing ~/.config/nvim/plugged/nvim-peekup/plugin/nvim-peekup.vim
000.212  000.212: sourcing ~/.config/nvim/plugged/vim-peekaboo/plugin/peekaboo.vim
000.195  000.195: sourcing ~/.config/nvim/plugged/vim-peekaboo/autoload/peekaboo.vim
```
