source ../setup.vim

func Test_Syntax()
  new
  vsp
  let lines =<< trim END
    set nocp noshowcmd noruler
    syn off
    set rtp^=$VIM_XML_RT
    e ./bug.dtd
    syn on
    so syntax/dtd.vim
  END
  call writefile(lines, g:SourceFilename)
  let buf = RunVimInTerminal('--clean -S ' .. g:SourceFilename, #{rows: 20, cols: 80})
  call term_sendkeys(buf, ":redraw!\<cr>")
  call term_wait(buf, 100)
  call term_dumpwrite(buf, 'output.dump')
  " clean up
  call StopVimInTerminal(buf)
  call delete(g:SourceFilename)
endfunc

call Test_Syntax()
qa!
