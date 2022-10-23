"------------------------------------------------------------------------------
"  Description: Vim Ada/GNAT compiler file
"     Language: Ada (GNAT, Alire)
"    Copyright: Copyright (C) 2022 … 2022 Martin Krischik
"   Maintainer:	Martin Krischi <krischik@users.sourceforge.net>k
"      Version: 5.0.0
"      History: 24.05.2006 MK Unified Headers
"    Help Page: compiler-alire
"------------------------------------------------------------------------------

if version < 700
    finish
endif

function alire#Make () dict					     " {{{1
   let &l:makeprg     = self.Get_Command('Make') . ' ' . self.Make_Options
   let &l:errorformat = self.Error_Format
   wall
   make
endfunction alire#Make						     " }}}1

function alire#Run () dict					     " {{{1
   let &l:makeprg     = self.Get_Command('Run') . ' ' . self.Run_Options
   let &l:errorformat = self.Error_Format
   wall
   make
endfunction alire#Make						     " }}}1

function alire#Get_Command (Command) dict			     " {{{1
   let l:Command = eval ('self.' . a:Command . '_Command')
   return eval (l:Command)
endfunction alire#Get_Command					     " }}}1

function alire#Set_Session (...) dict				     " {{{1
   if argc() == 1 && fnamemodify (argv(0), ':e') == 'gpr'
      call self.Set_Project_File (argv(0))
   elseif  strlen (v:servername) > 0
      call self.Set_Project_File (v:servername . '.gpr')
   endif
endfunction alire#Set_Session					     " }}}1

function alire#Set_Options (Options) dict			     " {{{1
   let self.Make_Options = a:Options
   let &l:makeprg = self.Get_Command('Make') . ' ' . self.Make_Options
endfunction alire#Set_Options					     " }}}1

function alire#New ()						     " {{{1
   let l:Retval = {
      \ 'Make'		   : function ('alire#Make'),
      \ 'Set_Project_File' : function ('alire#Set_Project_File'),
      \ 'Set_Session'      : function ('alire#Set_Session'),
      \ 'Get_Command'      : function ('alire#Get_Command'),
      \ 'Set_Options'	   : function ('alire#Set_Options'),
      \ 'Make_Command'     : '"alr build"',
      \ 'Make_Options'	   : '',
      \ 'Run_Command'      : '"alr run"',
      \ 'Run_Options'	   : '',
      \ 'Pretty_Command'   : '"alirepp " . expand("%:p")' ,
      \ 'Error_Format'     : '%f:%l:%c: %trror: %m,'   .
			   \ '%f:%l:%c: %tarning: %m,' .
			   \ '%f:%l:%c: (%ttyle) %m'}

   return l:Retval
endfunction alire#New						  " }}}1

finish " 1}}}

"------------------------------------------------------------------------------
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=0 wrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
