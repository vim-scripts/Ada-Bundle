This is a mirror of http://www.vim.org/scripts/script.php?script_id=1609

Contains all files for the new Ada mode. It also has a vim help file which you can call with

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

For some functionality you need a ctags programm. You can user either "gnat xref -v" or a patched [1] version of the exuberant Ctags [2].

Don't forget to actualy activate filetype and syntax support:

```vim
:filetype plugin indent on
:syntax enable
```

The Ada mode can be be further extened with the following Scripts:

 - backup.vim,				vimscript#1537
 - rainbow_parenthsis.vim,	vimscript#1561
 - nerd_comments.vim,		vimscript#1218
 - matchit.vim,				vimscript#39
 - taglist.vim,				vimscript#273

you can also use any of the bundle installer to get the newest version. For example:

```vim
:call dein#add('krischik/Ada-Bundle')
```

The GNU Ada project [3] offers ready patched binary rpm's including the Ada-Mode, all the scripts mentioned above and Ada aware exuberant Ctags for easy installation.

Reports errors and discuss improvements on: https://github.com/krischik/Ada-Bundle/issues

[1] vimscript#1535
[2] http://ctags.sourceforge.net
[3] http://gnuada.sourceforge.net
