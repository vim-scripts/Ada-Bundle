"------------------------------------------------------------------------------
"  Description: Vim Ada/GNAT compiler file
"     Language: Ada (GNAT)
"          $Id: gnat.vim 342 2006-07-27 19:03:11Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-07-27 21:03:11 +0200 (Do, 27 Jul 2006) $
"      Version: 3.4
"    $Revision: 342 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/compiler/gnat.vim $
"      History: 24.05.2006 MK Unified Headers
"		16.07.2006 MK Ada-Mode as vim-ball
"    Help Page: compiler-gnat
"------------------------------------------------------------------------------

if version < 700
    finish
else
    let current_compiler = "gnat"

    if !exists("g:gnat")
	let g:gnat = gnat#New ()
    endif

    execute "CompilerSet makeprg="     . escape (eval (g:gnat.Make_Command), ' ')
    execute "CompilerSet errorformat=" . escape (g:gnat.Error_Format, ' ')

   call ada#Map_Menu (
     \'GNAT.Build',
     \'<F7>',
     \'call gnat.Make ()')
   call ada#Map_Menu (
     \'GNAT.Tags',
     \'<F7>',
     \'call gnat.Tags ()')
   call ada#Map_Menu (
     \'GNAT.Set Projectfile\.\.\.',
     \'<F7>',
     \'call gnat.Set_Project_File ()')

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
