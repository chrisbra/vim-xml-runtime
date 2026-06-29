set nocp noshowcmd noruler spell spelllang=en
syn off
set rtp^=$VIM_XML_RT
e input.xrc
syn on
so syntax/xrc.vim
