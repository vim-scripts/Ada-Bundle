"------------------------------------------------------------------------------
"  Description: Options setable by the Ada plugin
"          $Id: ada_options.vim 314 2006-07-18 17:11:31Z krischik $
"    Copyright: Copyright (C) 2006 Martin Krischik
"   Maintainer:	Martin Krischik
"      $Author: krischik $
"        $Date: 2006-07-18 19:11:31 +0200 (Di, 18 Jul 2006) $
"      Version: 3.1 
"    $Revision: 314 $
"     $HeadURL: https://svn.sourceforge.net/svnroot/gnuada/trunk/tools/vim/ada_options.vim $
"      History:	24.05.2006 MK Unified Headers
"		16.07.2006 MK Ada-Mode as vim-ball
"	 Usage: copy content into your .vimrc and change options to your
"		likeing.
"    Help Page: ada-options
"------------------------------------------------------------------------------

    let   g:ada_extended_tagging	= 'list'
    let   g:ada_gnat_extensions		= 1
    let   g:ada_standard_types		= 1
    let   g:ada_space_errors		= 1
    unlet g:ada_line_errors		= 1
    let   g:ada_folding			= 1
    let   g:ada_abbrev			= 1
    let   g:ada_with_gnat_project_files	= 1
    let   g:ada_rainbow_color		= 1
    let   g:ada_default_compiler        = 'gnat'

    let   g:backup_directory		= '.backups'
    let   g:backup_purge			= 10

finish

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

" vim: textwidth=0 nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab
" vim: filetype=vim encoding=latin1 fileformat=unix
