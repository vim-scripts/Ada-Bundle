"------------------------------------------------------------------------------
"  Description: Vim Ada/Dec Ada compiler file
"     Language: Ada (Dec Ada)
"          $Id: gnat.vim 314 2006-07-18 17:11:31Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-07-18 19:11:31 +0200 (Di, 18 Jul 2006) $
"      Version: 3.2
"    $Revision: 314 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/compiler/gnat.vim $
"      History: 21.07.2006 MK New Dec Ada
"    Help Page: compiler-decada
"------------------------------------------------------------------------------

if version < 700
    finish
else
    if !exists("g:decada")
	let g:decada = decada#New ()
    endif

    let current_compiler = "decada"

    execute "CompilerSet makeprg="     . escape (g:decada.Make_Command, ' ')
    execute "CompilerSet errorformat=" . escape (g:decada.Error_Format, ' ')

    command! -buffer Build      :call g:decada.Build ()

    nnoremap <buffer> <F7>      :call g:decada.Build ()<CR>
    inoremap <buffer> <F7> <C-O>:call g:decada.Build ()<CR>

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
