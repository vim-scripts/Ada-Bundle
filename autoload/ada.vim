"------------------------------------------------------------------------------
"  Description: Perform Ada specific completion & tagging.
"     Language: Ada (2005)
"          $Id: ada.vim 306 2006-07-16 15:06:00Z krischik $
"   Maintainer:	Martin Krischik
"               Neil Bird <neil@fnxweb.com>
"      $Author: krischik $
"        $Date: 2006-07-16 17:06:00 +0200 (So, 16 Jul 2006) $
"      Version: 2.1 
"    $Revision: 306 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/autoload/ada.vim $
"      History: 24.05.2006 MK Unified Headers
"               26.05.2006 MK ' should not be in iskeyword.
"		16.07.2006 MK Ada-Mode as vim-ball
"    Help Page: ft-ada-functions
"------------------------------------------------------------------------------

if exists ('g:loaded_ada_autoload') || version < 700
   finish
else
   " Extract current Ada word across multiple lines
   " AdaWord ([line, column])\
   let g:loaded_ada_autoload  = 1
   let g:AdaWordRegex         = '\a\w*\(\_s*\.\_s*\a\w*\)*'
   let g:ada#Comment          = "\\v^(\"[^\"]*\"|'.'|[^\"']){-}\\zs\\s*--.*"
   let g:ada#Keywords         = []

   "--------------------------------------------------------------------------
   "
   "   add  Ada keywords
   "
   for Item in ['abort', 'else', 'new', 'return', 'abs', 'elsif', 'not', 'reverse', 'abstract', 'end', 'null', 'accept', 'entry', 'select', 'access', 'exception', 'of', 'separate', 'aliased', 'exit', 'or', 'subtype', 'all', 'others', 'synchronized', 'and', 'for', 'out', 'array', 'function', 'overriding', 'tagged', 'at', 'task', 'generic', 'package', 'terminate', 'begin', 'goto', 'pragma', 'then', 'body', 'private', 'type', 'if', 'procedure', 'case', 'in', 'protected', 'until', 'constant', 'interface', 'use', 'is', 'raise', 'declare', 'range', 'when', 'delay', 'limited', 'record', 'while', 'delta', 'loop', 'rem', 'with', 'digits', 'renames', 'do', 'mod', 'requeue', 'xor']
       let g:ada#Keywords += [{
               \ 'word':  Item,
               \ 'menu':  'keyword',
               \ 'info':  'Ada keyword.',
               \ 'kind':  'k',
               \ 'icase': 1}]
   endfor
   if exists ('g:ada_with_gnat_project_files')
       for Item in ['project']
          let g:ada#Keywords += [{
                  \ 'word':  Item,
                  \ 'menu':  'keyword',
                  \ 'info':  'GNAT projectfile keyword.',
                  \ 'kind':  'k',
                  \ 'icase': 1}]
       endfor
   endif

   "--------------------------------------------------------------------------
   "
   "   add  standart exception
   "
   for Item in ['Constraint_Error', 'Program_Error', 'Storage_Error', 'Tasking_Error', 'Status_Error', 'Mode_Error', 'Name_Error', 'Use_Error', 'Device_Error', 'End_Error', 'Data_Error', 'Layout_Error', 'Length_Error', 'Pattern_Error', 'Index_Error', 'Translation_Error', 'Time_Error', 'Argument_Error', 'Tag_Error', 'Picture_Error', 'Terminator_Error', 'Conversion_Error', 'Pointer_Error', 'Dereference_Error', 'Update_Error']
       let g:ada#Keywords += [{
               \ 'word':  Item,
               \ 'menu':  'exception',
               \ 'info':  'Ada standart exception.',
               \ 'kind':  'x',
               \ 'icase': 1}]
   endfor
   if exists ('g:ada_gnat_extensions')
       for Item in ['Assert_Failure']
           let g:ada#Keywords += [{
                   \ 'word':  Item,
                   \ 'menu':  'exception',
                   \ 'info':  'GNAT exception.',
                   \ 'kind':  'x',
                   \ 'icase': 1}]
       endfor
   endif

   "--------------------------------------------------------------------------
   "   
   "   add buildin types
   "
   for Item in ['Boolean', 'Integer', 'Natural', 'Positive', 'Float', 'Character', 'Wide_Character', 'Wide_Wide_Character', 'String', 'Wide_String', 'Wide_Wide_String', 'Duration']
       let g:ada#Keywords += [{
               \ 'word':  Item,
               \ 'menu':  'type',
               \ 'info':  'Ada buildin type.',
               \ 'kind':  't',
               \ 'icase': 1}]
   endfor
   if exists ('g:ada_gnat_extensions')
       for Item in ['Short_Integer', 'Short_Short_Integer', 'Long_Integer', 'Long_Long_Integer', 'Short_Float', 'Short_Short_Float', 'Long_Float', 'Long_Long_Float']
           let g:ada#Keywords += [{
                   \ 'word':  Item,
                   \ 'menu':  'type',
                   \ 'info':  'GNAT buildin type.',
                   \ 'kind':  't',
                   \ 'icase': 1}]
       endfor
   endif

   "--------------------------------------------------------------------------
   "
   "   add  Ada Attributes
   "
   for Item in ['''Access', '''Address', '''Adjacent', '''Aft', '''Alignment', '''Base', '''Bit_Order', '''Body_Version', '''Callable', '''Caller', '''Ceiling', '''Class', '''Component_Size', '''Compose', '''Constrained', '''Copy_Sign', '''Count', '''Definite', '''Delta', '''Denorm', '''Digits', '''Emax', '''Exponent', '''External_Tag', '''Epsilon', '''First', '''First_Bit', '''Floor', '''Fore', '''Fraction', '''Identity', '''Image', '''Input', '''Large', '''Last', '''Last_Bit', '''Leading_Part', '''Length', '''Machine', '''Machine_Emax', '''Machine_Emin', '''Machine_Mantissa', '''Machine_Overflows', '''Machine_Radix', '''Machine_Rounding', '''Machine_Rounds', '''Mantissa', '''Max', '''Max_Size_In_Storage_Elements', '''Min', '''Mod', '''Model', '''Model_Emin', '''Model_Epsilon', '''Model_Mantissa', '''Model_Small', '''Modulus', '''Output', '''Partition_ID', '''Pos', '''Position', '''Pred', '''Priority', '''Range', '''Read', '''Remainder', '''Round', '''Rounding', '''Safe_Emax', '''Safe_First', '''Safe_Large', '''Safe_Last', '''Safe_Small', '''Scale', '''Scaling', '''Signed_Zeros', '''Size', '''Small', '''Storage_Pool', '''Storage_Size', '''Stream_Size', '''Succ', '''Tag', '''Terminated', '''Truncation', '''Unbiased_Rounding', '''Unchecked_Access', '''Val', '''Valid', '''Value', '''Version', '''Wide_Image', '''Wide_Value', '''Wide_Wide_Image', '''Wide_Wide_Value', '''Wide_Wide_Width', '''Wide_Width', '''Width', '''Write']
       let g:ada#Keywords += [{
               \ 'word':  Item,
               \ 'menu':  'attribute',
               \ 'info':  'Ada attribute.',
               \ 'kind':  'a',
               \ 'icase': 1}]
   endfor
   if exists ('g:ada_gnat_extensions')
       for Item in ['''Abort_Signal', '''Address_Size', '''Asm_Input', '''Asm_Output', '''AST_Entry', '''Bit', '''Bit_Position', '''Code_Address', '''Default_Bit_Order', '''Elaborated', '''Elab_Body', '''Elab_Spec', '''Emax', '''Enum_Rep', '''Epsilon', '''Fixed_Value', '''Has_Access_Values', '''Has_Discriminants', '''Img', '''Integer_Value', '''Machine_Size', '''Max_Interrupt_Priority', '''Max_Priority', '''Maximum_Alignment', '''Mechanism_Code', '''Null_Parameter', '''Object_Size', '''Passed_By_Reference', '''Range_Length', '''Storage_Unit', '''Target_Name', '''Tick', '''To_Address', '''Type_Class', '''UET_Address', '''Unconstrained_Array', '''Universal_Literal_String', '''Unrestricted_Access', '''VADS_Size', '''Value_Size', '''Wchar_T_Size', '''Word_Size']
       let g:ada#Keywords += [{
               \ 'word':  Item,
               \ 'menu':  'attribute',
               \ 'info':  'GNAT attribute.',
               \ 'kind':  'a',
               \ 'icase': 1}]
       endfor
   endif

   "--------------------------------------------------------------------------
   "
   "   add  Ada Pragmas
   "
   for Item in ['All_Calls_Remote', 'Assert', 'Assertion_Policy', 'Asynchronous', 'Atomic', 'Atomic_Components', 'Attach_Handler', 'Controlled', 'Convention', 'Detect_Blocking', 'Discard_Names', 'Elaborate', 'Elaborate_All', 'Elaborate_Body', 'Export', 'Import', 'Inline', 'Inspection_Point', 'Interface (Obsolescent)', 'Interrupt_Handler', 'Interrupt_Priority', 'Linker_Options', 'List', 'Locking_Policy', 'Memory_Size (Obsolescent)', 'No_Return', 'Normalize_Scalars', 'Optimize', 'Pack', 'Page', 'Partition_Elaboration_Policy', 'Preelaborable_Initialization', 'Preelaborate', 'Priority', 'Priority_Specific_Dispatching', 'Profile', 'Pure', 'Queueing_Policy', 'Relative_Deadline', 'Remote_Call_Interface', 'Remote_Types', 'Restrictions', 'Reviewable', 'Shared (Obsolescent)', 'Shared_Passive', 'Storage_Size', 'Storage_Unit (Obsolescent)', 'Suppress', 'System_Name (Obsolescent)', 'Task_Dispatching_Policy', 'Unchecked_Union', 'Unsuppress', 'Volatile', 'Volatile_Components']
       let g:ada#Keywords += [{
               \ 'word':  Item,
               \ 'menu':  'pragma',
               \ 'info':  'Ada pragma.',
               \ 'kind':  'p',
               \ 'icase': 1}]
   endfor
   if exists ('g:ada_gnat_extensions')
       for Item in ['Abort_Defer', 'Ada_83', 'Ada_95', 'Ada_05', 'Annotate', 'Ast_Entry', 'C_Pass_By_Copy', 'Comment', 'Common_Object', 'Compile_Time_Warning', 'Complex_Representation', 'Component_Alignment', 'Convention_Identifier', 'CPP_Class', 'CPP_Constructor', 'CPP_Virtual', 'CPP_Vtable', 'Debug', 'Elaboration_Checks', 'Eliminate', 'Export_Exception', 'Export_Function', 'Export_Object', 'Export_Procedure', 'Export_Value', 'Export_Valued_Procedure', 'Extend_System', 'External', 'External_Name_Casing', 'Finalize_Storage_Only', 'Float_Representation', 'Ident', 'Import_Exception', 'Import_Function', 'Import_Object', 'Import_Procedure', 'Import_Valued_Procedure', 'Initialize_Scalars', 'Inline_Always', 'Inline_Generic', 'Interface_Name', 'Interrupt_State', 'Keep_Names', 'License', 'Link_With', 'Linker_Alias', 'Linker_Section', 'Long_Float', 'Machine_Attribute', 'Main_Storage', 'Obsolescent', 'Passive', 'Polling', 'Profile_Warnings', 'Propagate_Exceptions', 'Psect_Object', 'Pure_Function', 'Restriction_Warnings', 'Source_File_Name', 'Source_File_Name_Project', 'Source_Reference', 'Stream_Convert', 'Style_Checks', 'Subtitle', 'Suppress_All', 'Suppress_Exception_Locations', 'Suppress_Initialization', 'Task_Info', 'Task_Name', 'Task_Storage', 'Thread_Body', 'Time_Slice', 'Title', 'Unimplemented_Unit', 'Universal_Data', 'Unreferenced', 'Unreserve_All_Interrupts', 'Use_VADS_Size', 'Validity_Checks', 'Warnings', 'Weak_External']
           let g:ada#Keywords += [{
                   \ 'word':  Item,
                   \ 'menu':  'pragma',
                   \ 'info':  'GNAT pragma.',
                   \ 'kind':  'p',
                   \ 'icase': 1}]
       endfor
   endif

   "--------------------------------------------------------------------------
   "
   "
   function ada#Word (...)
      if a:0 > 1
         let linenr = a:1
         let colnr  = a:2 - 1
      else
         let linenr = line('.')
         let colnr  = col('.') - 1
      endif

      let line = substitute( getline(linenr), s:AdaComment, '', '' )

      " Cope with tag searching for items in comments; if we are, don't loop
      " backards looking for previous lines
      if colnr > strlen(line)
         " We were in a comment
         let line = getline(linenr)
         let search_prev_lines = 0
      else
         let search_prev_lines = 1
      endif

      " Go backwards until we find a match (Ada ID) that *doesn't* include our
      " location - i.e., the previous ID. This is because the current 'correct'
      " match will toggle matching/not matching as we traverse characters
      " backwards. Thus, we have to find the previous unrelated match, exclude
      " it, then use the next full match (ours).
      " Remember to convert vim column 'colnr' [1..n] to string offset [0..(n-1)]
      " ... but start, here, one after the required char.
      let newcol = colnr + 1
      while 1
         let newcol = newcol - 1
         if newcol < 0
            " Have to include previous line from file
            let linenr = linenr - 1
            if linenr < 1  ||  !search_prev_lines
               " Start of file or matching in a comment
               let linenr = 1
               let newcol = 0
               let ourmatch = match( line, s:AdaWordRegex )
               break
            endif
            " Get previous line, and prepend it to our search string
            let newline = substitute( getline(linenr), s:AdaComment, '', '' )
            let newcol  = strlen(newline) - 1
            let colnr   = colnr + newcol
            let line    = newline . line
         endif
         " Check to see if this is a match excluding 'us'
         let mend = newcol + matchend( strpart(line,newcol), s:AdaWordRegex ) - 1
         if mend >= newcol  &&  mend < colnr
            " Yes
            let ourmatch = mend+1 + match( strpart(line,mend+1), s:AdaWordRegex )
            break
         endif
      endwhile

      " Got anything?
      if ourmatch < 0
         return ''
      else
         let line = strpart( line, ourmatch)
      endif

      " Now simply add further lines until the match gets no bigger
      let matchstr = matchstr (line, s:AdaWordRegex)
      let lastline  = line('$')
      let linenr    = line('.') + 1
      while linenr <= lastline
         let lastmatch = matchstr
         let line = line . substitute (getline (linenr), s:AdaComment, '', '')
         let matchstr = matchstr (line, s:AdaWordRegex)
         if matchstr == lastmatch
            break
         endif
      endwhile

      " Strip whitespace & return
      return substitute (matchstr, '\s\+', '', 'g')
   endfunction ada#Word

   "--------------------------------------------------------------------------
   "
   "  List tags in quickfix window
   "
   function ada#List_Tag (...)
      if a:0 > 1
         let l:Tag_Word = ada#Word (a:1, a:2)
      elseif a:0 > 0
         let l:Tag_Word = a:1
      else
         let l:Tag_Word = ada#Word ()
      endif

      echo "Searching for " . l:Tag_Word

      let l:Tag_List = taglist (l:Tag_Word)
      let l:Error_List = []
      " 
      " add symbols
      "
      for Tag_Item in l:Tag_List
         if l:Tag_Item['kind'] == ''
            let l:Tag_Item['kind'] = 's'
         endif

         let l:Error_List += [ 
            \ l:Tag_Item['filename'] . '|' .
            \ l:Tag_Item['cmd']      . '|' .
            \ l:Tag_Item['kind']     . "\t" .
            \ l:Tag_Item['name'] ]
      endfor
      set errorformat=%f\|%l\|%m
      cexpr l:Error_List
      cwindow
   endfunction ada#List_Tag

   "--------------------------------------------------------------------------
   "
   " Word tag - include '.' and if Ada make uppercase
   "
   function ada#Jump_Tag (Word, Mode)    
      if a:Word == ''
         " Get current word
         let l:Word = ada#Word()
         if l:Word == ''
            throw "NOT_FOUND: no identifier found."
         endif
      else
         let l:Word = a:Word
      endif

      echo "Searching for " . l:Word

      try
         execute a:Mode l:Word
      catch /.*:E426:.*/
         let ignorecase = &ignorecase
         set ignorecase
         execute a:Mode l:Word
         let &ignorecase = ignorecase
      endtry
      
      return
   endfunction ada#Jump_Tag

   "--------------------------------------------------------------------------
   "
   " Backspace at end of line after auto-inserted commentstring '-- ' wipes it
   "
   function ada#Insert_Backspace ()
      let line = getline ('.')
      if col ('.') > strlen (line) &&
       \ match (line, '-- $') != -1 && 
       \ match (&comments,'--') != -1
         return "\<bs>\<bs>\<bs>"
      else
         return "\<bs>"
      endif

      return
   endfunction ada#InsertBackspace

   "--------------------------------------------------------------------------
   "
   " Word completion (^N/^R/^X^]) - force '.' inclusion
   function ada#Completion (cmd)
      set iskeyword+=46
      return a:cmd . "\<C-R>=ada#Completion_End ()\<CR>"
   endfunction ada#Completion

   function ada#Completion_End ()
      set iskeyword-=46
      return ''
   endfunction ada#Completion_End

   lockvar  g:AdaWordRegex
   lockvar  g:ada#Comment
   lockvar! g:ada#Keywords

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
" vim: textwidth=78 wrap tabstop=8 shiftwidth=3 softtabstop=3 expandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
