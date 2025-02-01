" Vim filetype plugin file
"     Language:	xml
"   Maintainer:	Christian Brabandt <cb@256bit.org>
" Last Changed:	2024 May 24
"   Repository:	https://github.com/chrisbra/vim-xml-ftplugin
" Previously
"    Maintainer:	Dan Sharp <dwsharp at users dot sourceforge dot net>
"    URL:		http://dwsharp.users.sourceforge.net/vim/ftplugin

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo&vim

setlocal commentstring=<!--\ %s\ -->
" Remove the middlepart from the comments section, as this causes problems:
" https://groups.google.com/d/msg/vim_dev/x4GT-nqa0Kg/jvtRnEbtAnMJ
setlocal comments=s:<!--,e:-->

setlocal formatoptions-=t
setlocal formatoptions+=croql
setlocal formatexpr=xmlformat#Format()

" XML:  thanks to Johannes Zellner and Akbar Ibrahim
" - case sensitive
" - don't match empty tags <fred/>
" - match <!--, --> style comments (but not --, --)
" - match <!, > inlined dtd's. This is not perfect, as it
"   gets confused for example by
"       <!ENTITY gt ">">
if exists("loaded_matchit")
    let b:match_ignorecase=0
    let b:match_words =
     \  '<:>,' .
     \  '<\@<=!\[CDATA\[:]]>,'.
     \  '<\@<=!--:-->,'.
     \  '<\@<=?\k\+:?>,'.
     \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
     \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>'
endif

" For Omni completion, by Mikolaj Machowski.
if exists('&ofu')
  setlocal ofu=xmlcomplete#CompleteTags
endif
command! -nargs=+ XMLns call xmlcomplete#CreateConnection(<f-args>)
command! -nargs=? XMLent call xmlcomplete#CreateEntConnection(<f-args>)

" Change the :browse e filter to primarily show xml-related files.
if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
    let  b:browsefilter="XML Files (*.xml)\t*.xml\n" .
    \ "DTD Files (*.dtd)\t*.dtd\n" .
    \ "XSD Files (*.xsd)\t*.xsd\n" .
    \ "All Files (*.*)\t*.*\n"
endif

" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal commentstring< comments< formatoptions< formatexpr<"

if expand('%:t') ==# 'default.xml'
    " https://github.com/LineageOS/android/blob/aa01966efc6b81db9e8301b24cff64ade113a684/default.xml#L1136-L1137
    setlocal include=<include\\s*name=
    let b:undo_ftplugin .= ' inc<'
endif
let b:undo_ftplugin .= " | unlet! b:match_ignorecase b:match_words b:browsefilter"

" Restore the saved compatibility options.
let &cpo = s:save_cpo
unlet s:save_cpo
