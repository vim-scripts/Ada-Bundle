"------------------------------------------------------------------------------
"  Description: Vim Ada omnicompletion file
"     Language:	Ada (2005)
"          $Id: adacomplete.vim 343 2006-07-28 17:54:11Z krischik $
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-07-28 19:54:11 +0200 (Fr, 28 Jul 2006) $
"      Version: 3.5
"    $Revision: 343 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/autoload/adacomplete.vim $
"      History: 24.05.2006 MK Unified Headers
"               26.05.2006 MK improved search for begin of word.
"		16.07.2006 MK Ada-Mode as vim-ball
"    Help Page: ft-ada-omni
"------------------------------------------------------------------------------

" Set completion with CTRL-X CTRL-O to autoloaded function.  This check is in
" place in case this script is sourced directly instead of using the autoload
" feature.  Do not set the option if already set since this results in an E117
" warning.
"
if exists ('+omnifunc') && &omnifunc == ""
    setlocal omnifunc=adacomplete#Complete
endif

if exists ('g:loaded_syntax_completion') || version < 700
    finish
else
   let g:loaded_syntax_completion = 34

   " Section: adacomplete#Complete () {{{1
   "
   " This function is used for the 'omnifunc' option.
   "
   function! adacomplete#Complete (findstart, base)
      if a:findstart == 1
	 return ada#User_Complete (a:findstart, a:base)
      else
         "
         " look up matches
         "
	 if exists ("g:ada_omni_with_keywords")
	    call ada#User_Complete (a:findstart, a:base)
	 endif	    
         "
         "  search tag file for matches
         "
         let l:Pattern  = '^' . a:base . '.*$'
         let l:Tag_List = taglist (l:Pattern)
         "
         " add symbols
         "
         for Tag_Item in l:Tag_List
	    if l:Tag_Item['kind'] == ''
	       "
	       " Tag created by gnat xref
	       "
	       let l:Match_Item = {
		  \ 'word':  l:Tag_Item['name'],
		  \ 'menu':  l:Tag_Item['filename'],
		  \ 'info':  "Symbol from file " . l:Tag_Item['filename'] . " line " . l:Tag_Item['cmd'],
		  \ 'kind':  's',
		  \ 'icase': 1}
	    else
	       "
	       " Tag created by ctags
	       "
	       let l:Info  = 'Symbol                : ' . l:Tag_Item['name']  . "\n"
	       let l:Info .= 'Of type               : ' . g:ada#Ctags_Kinds[l:Tag_Item['kind']][1]  . "\n"
	       let l:Info .= 'Defined in File       : ' . l:Tag_Item['filename'] . "\n"

	       if has_key( l:Tag_Item, 'package')
		  let l:Info .= 'Package               : ' . l:Tag_Item['package'] . "\n"
		  let l:Menu  = l:Tag_Item['package']
	       elseif has_key( l:Tag_Item, 'separate')
		  let l:Info .= 'Separate from Package : ' . l:Tag_Item['separate'] . "\n"
		  let l:Menu  = l:Tag_Item['separate']
	       elseif has_key( l:Tag_Item, 'packspec')
		  let l:Info .= 'Package Specification : ' . l:Tag_Item['packspec'] . "\n"
		  let l:Menu  = l:Tag_Item['packspec']
	       elseif has_key( l:Tag_Item, 'type')
		  let l:Info .= 'Datetype              : ' . l:Tag_Item['type'] . "\n"
		  let l:Menu  = l:Tag_Item['type']
	       else
		  let l:Menu  = l:Tag_Item['filename']
	       endif

	       let l:Match_Item = {
		  \ 'word':  l:Tag_Item['name'],
		  \ 'menu':  l:Menu,
		  \ 'info':  l:Info,
		  \ 'kind':  l:Tag_Item['kind'],
		  \ 'icase': 1}
	    endif
	    if complete_add (l:Match_Item) == 0
	       return []
	    endif
	    if complete_check ()
	       return []
	    endif
	 endfor
	 return []
      endif
   endfunction adacomplete#Complete

   " }}}1

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
