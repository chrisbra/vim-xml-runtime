source ../setup.vim

let s:filename='XSyntest.vim'

func Test_Syntax()
  new
  vsp
  let dir=expand("$VIM_XML_RT")
  let lines =<< trim END
    set nocp noshowcmd noruler
    syn off
    set rtp^=$VIM_XML_RT
    " Need to distinguish between Function and Identifier
    e input.xml
    syn on
  END
  call writefile(lines, g:SourceFilename)
  let buf = RunVimInTerminal('--clean -S ' .. g:SourceFilename, #{rows: 7, cols: 40})
  call term_sendkeys(buf, ":redraw!\<cr>")
  call term_wait(buf, 100)
  call term_dumpwrite(buf, g:dumpname)
  " clean up
  call StopVimInTerminal(buf)
endfunc

call Test_Syntax()
qa!
