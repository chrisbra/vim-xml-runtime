source ../setup.vim

func Skip(message, filename)
  call writefile([], a:filename)
  echom a:message
  qa!
endfunc


func Test_Syntax()
  new
  vsp
  let dir=expand("$VIM_XML_RT")
  let lines =<< trim END
    set nocp noshowcmd noruler
    syn off
    set rtp^=$VIM_XML_RT
    " Need to distinguish between Function and Identifier
    hi Function ctermfg=8
    hi Identifier ctermfg=6
    e input.xml
    syn on
  END
  call writefile(lines, s:filename)
  let buf = RunVimInTerminal('--clean -S ' .. s:filename, #{rows: 5, cols: 40})
  call term_sendkeys(buf, ":redraw!\<cr>")
  call term_wait(buf, 100)
  call term_dumpwrite(buf, s:dumpname)
  " clean up
  call StopVimInTerminal(buf)
endfunc

let s:filename='XSyntest.vim'
let s:dumpname='output.dump'
let s:skipped='SKIPPED'

" just in case
call CleanUpFiles([s:filename, s:dumpname, s:skipped])
if !has("terminal")
  call Skip("Terminal not supported, skipping!", s:skipped)
endif

if expand("$VIM_XML_RT")[0] == '$'
  call Skip("$VIM_XML_RT not set!", s:skipped)
endif

call Test_Syntax()
qa!
