"------------------------------------------------------------------------------
"  Description: Vim Ada/Dec Ada compiler file
"     Language: Ada (Dec Ada)
"          $Id: decada.vim 384 2006-09-10 07:34:48Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-09-10 09:34:48 +0200 (So, 10 Sep 2006) $
"      Version: 3.7
"    $Revision: 384 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/autoload/decada.vim $
"      History: 21.07.2006 MK New Dec Ada
"    Help Page: compiler-decada
"------------------------------------------------------------------------------

if exists("g:loaded_decada_autoload") || version < 700
    finish
else
   let g:loaded_decada_autoload = 34

   " Section: decada#Unit_Name () {{{1
   "
   function decada#Unit_Name () dict
       "	Convert filename into acs unit:
       "	    1:  remove the file extenstion.
       "	    2:  replace all double '_' or '-' with an dot (which denotes a separate)
       "	    3:  remove a trailing '_' (wich denotes a specification)
       return substitute (substitute (expand ("%:t:r"), '__\|-', ".", "g"), '_$', "", '')
   endfunction decada#Unit_Name

   " Section: decada#Make () {{{1
   "
   function decada#Make () dict
       let l:make_prg   = substitute (g:self.Make_Command, '%<', self.Unit_Name(), '')
       let &errorformat = g:self.Error_Format
       let &makeprg     = l:make_prg
       wall
       make
       copen
       set wrap
       wincmd W
   endfunction decada#Build


   " Section: decada#Set_Session () {{{1
   "
   function decada#Set_Session (...) dict
      if a:0 > 0
	 call ada#Switch_Session (a:1)
      elseif argc() == 0 && strlen (v:servername) > 0
	 call ada#Switch_Session (
	    \ expand('~')[0:-2] . ".vimfiles.session]" .
	    \ v:servername . ".vim")
      endif
      return
   endfunction decada#Set_Session

   " Section: decada#New () {{{1
   "
   function decada#New ()
      let Retval = {
         \ 'Make'	   : function ('decada#Make'),
         \ 'Unit_Name'	   : function ('decada#Unit_Name'),
	 \ 'Set_Session'   : function ('decada#Set_Session'),
	 \ 'Project_Dir'   : '',
         \ 'Make_Command'  : 'ACS COMPILE /Wait /Log /NoPreLoad /Optimize=Development /Debug %<',
         \ 'Error_Format'  : '%+A%%ADAC-%t-%m,%C  %#%m,%Zat line number %l in file %f,' .
			   \ '%+I%%ada-I-%m,%C  %#%m,%Zat line number %l in file %f'}

      return Retval
   endfunction gnat#New

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
