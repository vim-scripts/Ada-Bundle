finish
"------------------------------------------------------------------------------
"  Description: Options setable by the Ada plugin
"          $Id: ada_options.vim 406 2006-10-03 17:46:19Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-10-03 19:46:19 +0200 (Di, 03 Okt 2006) $
"      Version: 3.8
"    $Revision: 406 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/ada_options.vim $
"      History:	24.05.2006 MK Unified Headers
"		16.07.2006 MK Ada-Mode as vim-ball
"               02.10.2006 MK Folding for "gnat pretty"
"	 Usage: copy content into your .vimrc and change options to your
"		likeing.
"    Help Page: ada-options
"------------------------------------------------------------------------------

echoerr 'It is suggested to copy the content of ada_options into .vimrc!'

    " Section: Ada options {{{1 

    let   g:ada_abbrev                  = 1
    let   g:ada_default_compiler        = 'gnat'
    let   g:ada_extended_tagging        = 'list'
    let   g:ada_folding                 = 'i'
"   let   g:ada_folding			= 'gibxp'
"   let   g:ada_folding			= 'spftc'
    let   g:ada_rainbow_color           = 1
    let   g:ada_space_errors            = 1
    let   g:ada_standard_types          = 1
    let   g:ada_with_gnat_project_files = 1
"   let	  g:ada_extended_completion	= 1
"   let   g:ada_line_errors             = 1
"   let   g:ada_omni_with_keywords	= 1

    let   g:Tlist_Exit_OnlyWindow       = 1
    let   g:Tlist_File_Fold_Auto_Close  = 1
    let   g:Tlist_Sort_Type             = "name"

    let   g:NERD_use_ada_with_spaces    = 1

    let   g:backup_directory            = '.backups'
    let   g:backup_purge                = 10

    if &diff
        let   g:Tlist_Auto_Open		= 0
    else
        let   g:Tlist_Auto_Open		= 1
    endif

    filetype plugin indent on
    syntax enable

   " 1}}}
finish

" Section: Vimball options {{{1 
:.+2,.+13 MkVimball! ada

ada_options.vim
autoload/ada.vim
autoload/adacomplete.vim
autoload/decada.vim
autoload/gnat.vim
compiler/decada.vim
compiler/gnat.vim
doc/ada.txt
ftdetect/ada.vim
ftplugin/ada.vim
indent/ada.vim
syntax/ada.vim
" }}}1

" vim: textwidth=0 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix foldmethod=marker
