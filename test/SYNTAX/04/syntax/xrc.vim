let g:xml_syntax_folding=1
runtime syntax/xml.vim

" check spelling for the user-visible strings.
syn region xrcString matchgroup=xmlTagName start="<\z(label\|text\|tooltip\|value\)>" end="</\z1>" contains=xmlEntity,@Spell

" and also highlight them as such.
hi link xrcString ErrorMsg
