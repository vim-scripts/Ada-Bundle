This is a maintained mirror of http://www.vim.org/scripts/script.php?script_id=1609

Contains all files for the new Ada mode. It also has a vim help file which
you can call with

```vim
:help ada.txt.
```

Included is:

 - Syntax highlight
 - Auto indenting
 - Tag searching
 - Classic code completion
 - Omni code completion
 - Online help

For some functionality you need a ctags program.

Don't forget to actually activate filetype and syntax support:

```vim
:filetype plugin indent on
:syntax enable
```

The Ada mode can be be further extend with the following Scripts:

 - backup.vim,                          vimscript#1537
 - nerd_comments.vim,                   vimscript#1218
 - matchit.vim,                         vimscript#39
 - taglist.vim,                         vimscript#273

you can also use any of the bundle installer to get the newest version. For example:

```vim
:call dein#add('krischik/Ada-Bundle')
```

The GNU Ada project [3] offers ready patched binary rpm's including the Ada-Mode, all the
scripts mentioned above and Ada aware exuberant Ctags for easy installation.

Reports errors and discuss improvements on: https://github.com/krischik/Ada-Bundle/issues

Changes with official version, included in Vim/Neovim:

- Changed support from Rainbow Parenthesis to Rainbow Parentheses Improved
  plugin.
- Removed all tags commands which are now in base Vim (like jump to tag).
- Added support for Ale plugin.
- Updated help file.
- Removed support for Dec Ada compiler.
- Fixed and extended support for Vim sessions on loading GNAT project files
  (it is possible to enable or disable it).
- Added support for Ada 2012.
- Updated omni completion function: now it should be a bit faster and show
  items definitions too.
- Removed support for GNAT xref.
- Some other fixes for bugs.

If you want fully extend your experience with Vim/NeoVim as Ada IDE, I
recommend to use Vim-Ada bundle: https://github.com/thindil/vim-ada

All propositions and problems about this version of Ada-Bundle, please
report here, not to the maintainers of Vim or NeoVim.
