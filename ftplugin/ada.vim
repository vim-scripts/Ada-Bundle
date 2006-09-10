"------------------------------------------------------------------------------
"  Description: Perform Ada specific completion & tagging.
"     Language: Ada (2005)
"          $Id: ada.vim 370 2006-08-28 15:30:18Z krischik $
"   Maintainer: Martin Krischik
"               Neil Bird <neil@fnxweb.com>
"      $Author: krischik $
"        $Date: 2006-08-28 17:30:18 +0200 (Mo, 28 Aug 2006) $
"      Version: 3.7
"    $Revision: 370 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/ftplugin/ada.vim $
"      History: 24.05.2006 MK Unified Headers
"               26.05.2006 MK ' should not be in iskeyword.
"               16.07.2006 MK Ada-Mode as vim-ball
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
   let b:did_ftplugin = 36

   "
   " Temporarily set cpoptions to ensure the script loads OK
   "
   let s:cpoptions = &cpoptions
   set cpoptions-=C

   " Section: Comments {{{1
   "
   setlocal comments=O:--,:--\ \
   setlocal commentstring=--\ \ %s
   setlocal complete=.,w,b,u,t,i

   " Section: Tagging {{{1
   "
   if exists ("g:ada_extended_tagging")
      " Make local tag mappings for this buffer (if not already set)
      if g:ada_extended_tagging == 'jump'
         if mapcheck('<C-]>','n') == ''
            nnoremap <unique> <buffer> <C-]>    :call ada#Jump_Tag ('', 'tjump')<cr>
         endif
         if mapcheck('g<C-]>','n') == ''
            nnoremap <unique> <buffer> g<C-]>   :call ada#Jump_Tag ('','stjump')<cr>
         endif
      elseif g:ada_extended_tagging == 'list'
         if mapcheck('<C-]>','n') == ''
            nnoremap <unique> <buffer> <C-]>    :call ada#List_Tag ()<cr>
         endif
         if mapcheck('g<C-]>','n') == ''
            nnoremap <unique> <buffer> g<C-]>   :call ada#List_Tag ()<cr>
         endif
      endif
   endif

   " Section: Completion {{{1
   "
   setlocal completefunc=ada#User_Complete
   setlocal omnifunc=adacomplete#Complete

   if exists ("g:ada_extended_completion")
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
   endif

   " Section: Matchit {{{1
   "
   " Only do this when not done yet for this buffer & matchit is used
   "
   if !exists ("b:match_words")  &&
     \ exists ("loaded_matchit")
      "
      " The following lines enable the macros/matchit.vim plugin for
      " Ada-specific extended matching with the % key.
      "
      let s:notend      = '\%(\<end\s\+\)\@<!'
      let b:match_words =
         \ s:notend . '\<if\>:\<elsif\>:\<else\>:\<end\>\s\+\<if\>,' .
         \ s:notend . '\<case\>:\<when\>:\<end\>\s\+\<case\>,' .
         \ '\%(\<while\>.*\|\<for\>.*\|'.s:notend.'\)\<loop\>:\<end\>\s\+\<loop\>,' .
         \ '\%(\<do\>\|\<begin\>\):\<exception\>:\<end\>\s*\%($\|[;A-Z]\),' .
         \ s:notend . '\<record\>:\<end\>\s\+\<record\>'
   endif

   " Section: Compiler {{{1
   "
   if ! exists("current_compiler")                 ||
      \ current_compiler != g:ada_default_compiler
      execute "compiler " . g:ada_default_compiler
   endif

   " Section: Folding {{{1
   "
   if exists("g:ada_folding")
      setlocal foldmethod=indent
      setlocal foldignore=--
      setlocal tabstop=8
      setlocal softtabstop=3
      setlocal shiftwidth=3
   endif

   " Section: Abbrev {{{1
   "
   if exists("g:ada_abbrev")
      iabbrev ret  return
      iabbrev proc procedure
      iabbrev pack package
      iabbrev func function
   endif

   " Section: Commands, Mapping, Menus {{{1
   "
   call ada#Map_Popup (
      \ 'Tag.List',
      \  'l',
      \ 'call ada#List_Tag ()')
   call ada#Map_Popup (
      \'Tag.Jump',
      \'j',
      \'call ada#Jump_Tag ()')
   call ada#Map_Menu (
      \'Tag.Create File',
      \':AdaTagFile',
      \'call ada#Create_Tags (''file'')')
   call ada#Map_Menu (
      \'Tag.Create Dir',
      \':AdaTagDir',
      \'call ada#Create_Tags (''dir'')')

   call ada#Map_Menu (
      \'Highlight.Toggle Space Errors',
      \ ':AdaSpaces',
      \'call ada#Switch_Syntax_Option (''space_errors'')')
   call ada#Map_Menu (
      \'Highlight.Toggle Lines Errors',
      \ ':AdaLines',
      \'call ada#Switch_Syntax_Option (''line_errors'')')
   call ada#Map_Menu (
      \'Highlight.Toggle Rainbow Color',
      \ ':AdaRainbow',
      \'call ada#Switch_Syntax_Option (''rainbow_color'')')
   call ada#Map_Menu (
      \'Highlight.Toggle Standard Types',
      \ ':AdaTypes',
      \'call ada#Switch_Syntax_Option (''standard_types'')')

   " 1}}}
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
" vim: filetype=vim encoding=latin1 fileformat=unix foldmethod=marker nospell
