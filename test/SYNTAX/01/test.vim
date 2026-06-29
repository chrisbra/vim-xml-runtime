set nocp noshowcmd noruler
syn off
set rtp^=$VIM_XML_RT
" Need to distinguish between Function and Identifier
" for xmlTag and xmlEndTag
hi Function ctermfg=8
hi Identifier ctermfg=6
e input.xml
syn on
