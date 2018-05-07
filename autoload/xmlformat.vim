" Vim plugin for formatting XML
" Last Change: Thu, 15 Jan 2015 21:26:55 +0100
" Version: 0.1
" Author: Christian Brabandt <cb@256bit.org>
" Script:  http://www.vim.org/scripts/script.php?script_id=
" License: VIM License
" GetLatestVimScripts: ???? 18 :AutoInstall: xmlformat.vim
" Documentation: see :h xmlformat.txt (TODO!)
" ---------------------------------------------------------------------
" Load Once: {{{1
if exists("g:loaded_xmlformat") || &cp
  finish
endif
let g:loaded_xmlformat = 1
let s:keepcpo       = &cpo
set cpo&vim

" Main function: Format the input {{{1
func! xmlformat#Format()
  let sw  = shiftwidth()
  let result = []
  let lastitem = ''
  let s:indent = 0
  let is_xml_decl = 0
  " split on `<`, but don't split on very first opening <
  for item in split(getline(v:lnum), '.\@<=[>]\zs')
    if s:EndTag(item)
      let s:indent = (s:indent > 0 ? s:indent - 1 : 0)
      call add(result, s:Indent(item))
    elseif s:EmptyTag(lastitem)
      call add(result, s:Indent(item))
    elseif s:StartTag(lastitem) && !s:IsXMLDecl(lastitem)
      let s:indent += 1
      call add(result, s:Indent(item))
     else
       call add(result, s:Indent(item))
     endif
     let lastitem = item
   endfor

   exe v:lnum. ",". (v:lnum + v:count - 1). 'd'
   call append(v:lnum - 1, result)

  " do not run internal formatter!
  return 0 
endfunc
" Check if given tag is XML Declaration header {{{1
func! s:IsXMLDecl(tag)
  return a:tag =~? '^\s*<?xml\s\?\%(version="[^"]*"\)\?\s\?\%(encoding="[^"]*"\)\? ?>\s*$'
endfunc
" Return tag indented by current level {{{1
func! s:Indent(item)
  return repeat(' ', shiftwidth()*s:indent).a:item
endfu
" Check if tag is a new opening tag <tag> {{{1
func! s:StartTag(tag)
  return a:tag =~? '^\s*<[^/]'
endfunc
" Check if tag is a closing tag </tag> {{{1
func! s:EndTag(tag)
  return a:tag =~? '^\s*</'
endfunc
" Check if tag is empty <tag/> {{{1
func! s:EmptyTag(tag)
  return a:tag =~ '/>\s*$'
endfunc
" Restoration And Modelines: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" Modeline {{{1
" vim: fdm=marker fdl=0 ts=2 et sw=0 sts=-1
