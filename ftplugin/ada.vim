"------------------------------------------------------------------------------
"  Description: Perform Ada specific completion & tagging.
"     Language: Ada (2005)
"          $Id: ada.vim 306 2006-07-16 15:06:00Z krischik $
"   Maintainer:	Martin Krischik
"               Neil Bird <neil@fnxweb.com>
"      $Author: krischik $
"        $Date: 2006-07-16 17:06:00 +0200 (So, 16 Jul 2006) $
"      Version: 3.0 
"    $Revision: 306 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/ftplugin/ada.vim $
"      History: 24.05.2006 MK Unified Headers
"               26.05.2006 MK ' should not be in iskeyword.
"		16.07.2006 MK Ada-Mode as vim-ball
"    Help Page: ft-ada-plugin
"------------------------------------------------------------------------------
" Provides mapping overrides for tag jumping that figure out the current
" Ada object and tag jump to that, not the 'simple' vim word.
" Similarly allows <Ctrl-N> matching of full-length ada entities from tags.
"------------------------------------------------------------------------------

" Only do this when not done yet for this buffer
if exists ("b:did_ftplugin") || version < 700
    finish
else
   " Don't load another plugin for this buffer
   let b:did_ftplugin = 1
   
   " Temporarily set cpoptions to ensure the script loads OK
   let s:cpoptions = &cpoptions
   set cpoptions-=C

   " Ada comments
   setlocal comments+=O:--
   setlocal complete=.,w,b,u,t,i
   setlocal completeopt=menuone

   if exists ('&omnifunc')
       setlocal omnifunc=adacomplete#Complete
   endif

   if exists ("g:ada_extended_tagging")
      " Make local tag mappings for this buffer (if not already set)
      if g:ada_extended_tagging = 'jump' then
         if mapcheck('<C-]>','n') == ''
            nnoremap <unique> <buffer> <C-]>    :call ada#Jump_Tag ('', 'tjump')<cr>
         endif
         if mapcheck('g<C-]>','n') == ''
            nnoremap <unique> <buffer> g<C-]>   :call ada#Jump_Tag ('','stjump')<cr>
         endif
      elseif g:ada_extended_tagging = 'list'
         if mapcheck('<C-]>','n') == ''
            nnoremap <unique> <buffer> <C-]>    :call ada#List_Tag ('')<cr>
         endif
         if mapcheck('g<C-]>','n') == ''
            nnoremap <unique> <buffer> g<C-]>   :call ada#List_Tag ('')<cr>
         endif
      endif
   endif

   if mapcheck ('<C-N>','i') == ''
      inoremap <unique> <buffer> <C-N> <C-R>=ada#Completion("\<lt>C-N>")<cr>
   endif
   if mapcheck ('<C-P>','i') == ''
      inoremap <unique> <buffer> <C-P> <C-R>=ada#Completion("\<lt>C-P>")<cr>
   endif
   if mapcheck ('<C-X><C-]>','i') == ''
      inoremap <unique> <buffer> <C-X><C-]> <C-R>=<SID>ada#Completion("\<lt>C-X>\<lt>C-]>")<cr>
   endif
   if mapcheck ('<bs>','i') == ''
      inoremap <silent> <unique> <buffer> <bs> <C-R>=ada#Insert_Backspace ()<cr>
   endif

   " Only do this when not done yet for this buffer & matchit is used
   if ! exists ("b:match_words")  &&  exists ("loaded_matchit")
      " The following lines enable the macros/matchit.vim plugin for
      " Ada-specific extended matching with the % key.
      let s:notend = '\%(\<end\s\+\)\@<!'
      let b:match_words=
      \ s:notend . '\<if\>:\<elsif\>:\<else\>:\<end\>\s\+\<if\>,' .
      \ s:notend . '\<case\>:\<when\>:\<end\>\s\+\<case\>,' .
      \ '\%(\<while\>.*\|\<for\>.*\|'.s:notend.'\)\<loop\>:\<end\>\s\+\<loop\>,' .
      \ '\%(\<interface\>.*\|\<synchronized\>.*\|\<overriding\>,' .
      \ '\%(\<do\>\|\<begin\>\):\<exception\>:\<end\>\s*\%($\|[;A-Z]\),' .
      \ s:notend . '\<record\>:\<end\>\s\+\<record\>'
   endif

   if exists ("g:ada_default_compiler")
      execute "autocmd FileType ada compiler " . g:ada_default_compiler
   endif

   function s:Map_Menu (Text, Keys, Command)
      execute 
        \ "41menu " .
        \ "Plugin.Ada." . escape(a:Text, ' ') .
        \ "<Tab>"       . escape(g:mapleader . "a" . a:Keys , '\') .
        \ " :"          . a:Command . "<CR>"
      execute 
        \ "nnoremap " .
        \ escape(g:mapleader . "a" . a:Keys , '\') .
        \" :" . a:Command . "<CR>"
      execute 
        \ "inoremap " .
        \ escape(g:mapleader . "a" . a:Keys , '\') .
        \" <C-O>:" . a:Command . "<CR>"
      return
   endfunction

   call s:Map_Menu ('Tag List', 'l', 'call ada#List_Tag ()')
   call s:Map_Menu ('Tag Jump', 'j', 'call ada#Jump_Tag ()')

   delfunction s:Map_Menu

   " Reset cpoptions
   let &cpoptions = s:cpoptions
   unlet s:cpoptions

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
" vim: textwidth=78 nowrap tabstop=8 shiftwidth=3 softtabstop=3 expandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
