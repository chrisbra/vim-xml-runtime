set nocp noshowcmd noruler
syn off
set rtp^=$VIM_XML_RT
e ./bug.dtd
syn on
so syntax/dtd.vim
