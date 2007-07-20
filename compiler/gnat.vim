"------------------------------------------------------------------------------
"  Description: Vim Ada/GNAT compiler file
"     Language: Ada (GNAT)
"          $Id: gnat.vim 745 2007-07-08 15:57:40Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2007-07-08 17:57:40 +0200 (So, 08 Jul 2007) $
"      Version: 4.4
"    $Revision: 745 $
"     $HeadURL: http://gnuada.svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/compiler/gnat.vim $
"      History: 24.05.2006 MK Unified Headers
"		16.07.2006 MK Ada-Mode as vim-ball
"               15.10.2006 MK Bram's suggestion for runtime integration
"    Help Page: compiler-gnat
"------------------------------------------------------------------------------

if (exists("current_compiler")	    &&
   \ current_compiler == "gnat")    ||
   \ version < 700
   finish
endif

let current_compiler = "gnat"

if !exists("g:gnat")
   let g:gnat = gnat#New ()

   call ada#Map_Menu (
      \ 'GNAT.Build',
      \ '<F7>',
      \ 'call gnat.Make ()')
   call ada#Map_Menu (
      \ 'GNAT.Pretty Print',
      \ ':GnatPretty',
      \ 'call gnat.Pretty ()')
   call ada#Map_Menu (
      \ 'GNAT.Tags',
      \ ':GnatTags',
      \ 'call gnat.Tags ()')
   call ada#Map_Menu (
      \ 'GNAT.Find',
      \ ':GnatFind',
      \ 'call gnat.Find ()')
   call ada#Map_Menu (
      \ 'GNAT.Set Projectfile\.\.\.',
      \ ':SetProject',
      \ 'call gnat.Set_Project_File ()')

   call g:gnat.Set_Session ()
endif

if exists(":CompilerSet") != 2
   "
   " plugin loaded by other means then the "compiler" command
   "
   command -nargs=* CompilerSet setlocal <args>
endif

execute "CompilerSet makeprg="     . escape (g:gnat.Get_Command('Make'), ' ')
execute "CompilerSet errorformat=" . escape (g:gnat.Error_Format, ' ')

finish " 1}}}

"------------------------------------------------------------------------------
"   Copyright (C) 2006  Martin Krischik
"
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=0 wrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
