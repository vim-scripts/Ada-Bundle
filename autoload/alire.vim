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

function alire#Set_Project_File (...) dict			     " {{{1
   if a:0 > 0
      let self.Project_File = a:1

      if ! filereadable (self.Project_File)
	      let self.Project_File = findfile (
	    \ fnamemodify (self.Project_File, ':r'),
	    \ $ADA_PROJECT_PATH,
	    \ 1)
      endif
   elseif strlen (self.Project_File) > 0
      let self.Project_File = browse (0, 'GNAT Project File?', '', self.Project_File)
   elseif expand ("%:e") == 'gpr'
      let self.Project_File = browse (0, 'GNAT Project File?', '', expand ("%:e"))
   else
      let self.Project_File = browse (0, 'GNAT Project File?', '', 'default.gpr')
   endif

   if self.Project_File[strlen(self.Project_File) - 4:] == ".gpr"
      if exists('g:ale_enabled')
	 let g:ale_ada_aliremake_options = "-P " . self.Project_File . " -alirewa -alireq"
	 let g:ale_ada_adals_project = self.Project_File
	 let g:ale_lsp_root = {'adals': fnamemodify(self.Project_File, ':p:h') }
	 let g:ale_ada_alirepp_options = "-P " . self.Project_File
	 call ale#lsp_linter#SendRequest('%',
		  \ 'adals',
		  \ ale#lsp#message#DidChangeConfiguration('%',
			\ {'ada' : {"projectFile" : self.Project_File}}))
      endif
      let self.Make_Command = '"aliremake -P " . self.Project_File . "  -F -alireef"'
      let self.Pretty_Command = '"alirepp -P " . self.Project_File'
      let &l:makeprg  = "aliremake -P " . self.Project_File . "  -F -alireef"
      if exists("g:ada_create_session")
	 call ada#Switch_Session(self.Project_File . '.vim')
      endif
   endif

endfunction alire#Set_Project_File				     " }}}1

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
      \ 'Project_File'     : '',
      \ 'Make_Command'     : '"aliremake -F -alireef " . expand("%:p")',
      \ 'Make_Options'	   : '',
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
