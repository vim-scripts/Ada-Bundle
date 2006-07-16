"------------------------------------------------------------------------------
"  Description: Vim Ada/GNAT compiler file
"     Language: Ada (GNAT)
"          $Id: gnat.vim 306 2006-07-16 15:06:00Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-07-16 17:06:00 +0200 (So, 16 Jul 2006) $
"      Version: 2.0 
"    $Revision: 306 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/compiler/gnat.vim $
"      History: 24.05.2006 MK Unified Headers
"		16.07.2006 MK Ada-Mode as vim-ball
"    Help Page: compiler-gnat
"------------------------------------------------------------------------------

if exists("current_compiler") || version < 700
    finish
else
    function s:Make () dict
	let &makeprg	    = eval (self.Make_Command)
	let &errorformat    = self.Error_Format
	wall
	make
	copen
	set wrap
	wincmd W
    endfunction Make 

    function s:Find () dict
	execute "!" . eval (self.Find_Command)
    endfunction Make 
    
    let g:gnat = {
	\ 'Make'	    : function ('s:Make'),
	\ 'Find'	    : function ('s:Find'),
	\ 'Project_File'    : 'default.gpr',
	\ 'Make_Command'    : '"gnat make -P " . gnat.Project_File . " "',
	\ 'Find_Program'    : '"gnat find -P " . gnat.Project_File . " "',
	\ 'Tags_Command'    : '"gnat xref -P " . gnat.Project_File . " -v  *.AD*"',
	\ 'Error_Format'    : '%f:%l:%c: %trror: %m,'   .
			    \ '%f:%l:%c: %tarning: %m,' .
			    \ '%f:%l:%c: (%ttyle) %m'}

    let &makeprg	= eval (g:gnat.Make_Command)
    let &errorformat    = g:gnat.Error_Format

    command Make	:call g:gnat.Make ()

    let current_compiler = "gnat"
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
" vim: textwidth=78 wrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
