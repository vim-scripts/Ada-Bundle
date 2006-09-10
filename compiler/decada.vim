"------------------------------------------------------------------------------
"  Description: Vim Ada/Dec Ada compiler file
"     Language: Ada (Dec Ada)
"          $Id: decada.vim 370 2006-08-28 15:30:18Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-08-28 17:30:18 +0200 (Mo, 28 Aug 2006) $
"      Version: 3.7
"    $Revision: 370 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/compiler/decada.vim $
"      History: 21.07.2006 MK New Dec Ada
"    Help Page: compiler-decada
"------------------------------------------------------------------------------

if (exists("current_compiler")	    &&
   \ current_compiler == "decada")  ||
   \ version < 700
   finish
else
   let current_compiler = "decada"

   if !exists("g:decada")
      let g:decada = decada#New ()
   endif

   if exists(":CompilerSet") != 2
      " 
      " plugin loaded by other means then the "compiler" command
      "
      command -nargs=* CompilerSet setlocal <args>
   endif

   call g:decada.Set_Session ()

   execute "CompilerSet makeprg="     . escape (g:decada.Make_Command, ' ')
   execute "CompilerSet errorformat=" . escape (g:decada.Error_Format, ' ')

   call ada#Map_Menu (
     \'GNAT.Build',
     \'<F7>',
     \'call decada.Make ()')

   " 1}}}
   finish
endif

"------------------------------------------------------------------------------
"   Copyright (C) 2006  Martin Krischik
"
"   This program is free software; you can redistribute it and/or
"   modify it under the terms of the GNU General Public License
"   as published by the Free Software Foundation; either version 2
"   of the License, or (at your option) any later version.
"
"   This program is distributed in the hope that it will be useful,
"   but WITHOUT ANY WARRANTY; without even the implied warranty of
"   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"   GNU General Public License for more details.
"
"   You should have received a copy of the GNU General Public License
"   along with this program; if not, write to the Free Software
"   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
"------------------------------------------------------------------------------
" vim: textwidth=78 wrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix foldmethod=marker
