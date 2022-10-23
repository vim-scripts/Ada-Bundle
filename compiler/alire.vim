"------------------------------------------------------------------------------
"  Description: Vim Ada/GNAT compiler file
"     Language: Ada (GNAT, Alire)
"    Copyright: Copyright (C) 2022 … 2022 Martin Krischik
"   Maintainer:	Martin Krischi <krischik@users.sourceforge.net>k
"      Version: 5.0.0
"      History: 24.05.2006 MK Unified Headers
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

   call ada#Map_Menu (
      \ 'Set Project options\.\.\.',
      \ ':SetOptions',
      \ 'call alire.Set_Options',
      \ '')

   call g:alire.Set_Session ()
endif

if exists(":CompilerSet") != 2
   "
   " plugin loaded by other means then the "compiler" command
   "
   command -nargs=* CompilerSet setlocal <args>
endif

execute "CompilerSet makeprg="     . escape (g:alire.Get_Command('Make'), ' ')
execute "CompilerSet errorformat=" . escape (g:alire.Error_Format, ' ')

finish " 1}}}

"------------------------------------------------------------------------------
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=0 wrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
