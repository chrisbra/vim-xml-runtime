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

func! s:IsXMLDecl(tag)
  return a:tag =~? '^\s*<?xml\s\?\%(version="[^"]*"\)\?\s\?\%(encoding="[^"]*"\)\? ?>\s*$'
endfunc

func! s:Indent(item)
  return repeat(' ', shiftwidth()*s:indent).a:item
endfu

func! s:StartTag(tag)
  return a:tag =~? '^\s*<[^/]'
endfunc

func! s:EndTag(tag)
  return a:tag =~? '^\s*</'
endfunc

func! s:EmptyTag(tag)
  return a:tag =~ '/>\s*$'
endfunc

" Debug!
"set debug=msg
"set formatexpr=xmlformat#Format()
