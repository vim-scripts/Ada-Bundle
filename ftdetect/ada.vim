"------------------------------------------------------------------------------
"  Description: Vim Ada detection file
"     Language: Ada (2012)
"    Copyright: Copyright (C) 2006 … 2022 Martin Krischik
"   Maintainer: Martin Krischik <krischik@users.sourceforge.net>
"               Bartek Jasicki <thindil@laeran.pl>
"      Version: 5.1.0
"      History: 24.05.2006 MK Unified Headers
"		16.07.2006 MK Ada-Mode as vim-ball
"		15.10.2006 MK Bram's suggestion for runtime integration
"		05.11.2006 MK Bram suggested to save on spaces
"		28.08.2022 MK Merge Ada 2012 changes from thindil
"		01.09.2022 MK Use GitHub und dein to publish new versions
"		25.10.2022 MK Add Alire compiler support
"    Help Page: ft-ada-detect
"------------------------------------------------------------------------------

if exists("s:loaded_ftdetect_ada")
    finish
endif

let s:loaded_ftdetect_ada=45

autocmd BufNewFile,BufRead *.gpr setfiletype ada

finish " 1}}}

"------------------------------------------------------------------------------
"   Vim is Charityware - see ":help license" or uganda.txt for licence details.
"------------------------------------------------------------------------------
" vim: textwidth=78 nowrap tabstop=8 shiftwidth=3 softtabstop=3 noexpandtab
" vim: foldmethod=marker
