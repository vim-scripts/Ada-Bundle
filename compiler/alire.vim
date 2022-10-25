"------------------------------------------------------------------------------
"  Description: Vim Ada/GNAT compiler file
"     Language: Ada (GNAT, Alire)
"    Copyright: Copyright (C) 2022 … 2022 Martin Krischik
"   Maintainer:	Martin Krischi <krischik@users.sourceforge.net>k
"      Version: 5.1.0
"      History: 25.10.2022 MK Add Alire compiler support
"    Help Page: compiler-alire
"------------------------------------------------------------------------------

if (exists("current_compiler")	    &&
   \ current_compiler == "alire")    ||
   \ version < 700
   finish
endif

let current_compiler = "alire"

if !exists("g:alire")
   let g:alire = alire#New ()

   " Map_Menu parameter:
   "  Text:	Menu text to display
   "  Keys:	Key shortcut to define (used only when g:mapleader is used)
   "  Command:  Command shortcut to define
   "  Function: Function to call
   "  Args:	Additional parameter.

   call ada#Map_Menu (
      \ 'Run executable built',
      \ 'ar',
      \ 'AlireRun',
      \ 'call alire.Run',
      \ '')
   call ada#Map_Menu (
      \ 'Clean project',
      \ 'ac',
      \ 'AlireClean',
      \ 'call alire.Clean',
      \ '')
   call ada#Map_Menu (
      \ 'Set Project options\.\.\.',
      \ 'ao',
      \ 'AlireSet',
      \ 'call alire.Set_Options',
      \ '')
   call ada#Map_Menu (
      \ 'Read session',
      \ 'ar',
      \ 'AlireRead',
      \ 'ada#Switch_Session',
      \ '"alire.vim"')
endif

if exists(":CompilerSet") != 2
   "
   " plugin loaded by other means then the "compiler" command
   "
   command -nargs=* CompilerSet setlocal <args>
endif

execute "CompilerSet makeprg="     . escape (g:alire.Get_Command('Make'), ' ')
execute "CompilerSet errorformat=" . escape (g:alire.Error_Format, ' ')

if exists("g:ada_create_session")
   call ada#Switch_Session('alire.vim')
endif

finish " 1}}}

"------------------------------------------------------------------------------
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=0 wrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker