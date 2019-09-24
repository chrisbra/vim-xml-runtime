" Common initialization
set nocp
set rtp^=$VIM_XML_RT

" global Variables
let g:skipped='SKIPPED'
let g:SourceFilename='XSyntest.vim'
let g:dumpname='output.dump'

" helper functions
function! NewWindow(height, width) abort
  exe a:height . 'new'
  exe a:width . 'vsp'
  set winfixwidth winfixheight
  redraw!
endfunction

function! CleanUpFiles(files) abort
  for file in a:files
    call delete(file)
  endfor
endfunction

func RunVimInTerminal(arguments, options)
  " If Vim doesn't exit a swap file remains, causing other tests to fail.
  " Remove it here.
  call delete(".swp")

  if exists('$COLORFGBG')
    " Clear $COLORFGBG to avoid 'background' being set to "dark", which will
    " only be corrected if the response to t_RB is received, which may be too
    " late.
    let $COLORFGBG = ''
  endif

  " Always do this with 256 colors and a light background.
  set t_Co=256 background=light
  hi Normal ctermfg=NONE ctermbg=NONE

  let cmd = v:progpath .. ' ' .. a:arguments

  let buf = term_start(cmd, {
	\ 'curwin': 1,
	\ 'term_rows': get(a:options, 'rows', 20),
	\ 'term_cols': get(a:options, 'cols', 75),
	\ })

  " Need to sleep for about half a second
  sleep 1
  return buf
endfunc

" Stop a Vim running in terminal buffer "buf".
func StopVimInTerminal(buf)
  " CTRL-O : works both in Normal mode and Insert mode to start a command line.
  " In Command-line it's inserted, the CTRL-U removes it again.
  call term_sendkeys(a:buf, "\<C-O>:\<C-U>qa!\<cr>")

  sleep 10ms
  only!
endfunc

func Skip(message, filename)
  call writefile([], a:filename)
  echom a:message
  qa!
endfunc

" just in case
call CleanUpFiles([g:SourceFilename, g:dumpname, g:skipped])
if !has("terminal")
  call Skip("Terminal not supported, skipping!", g:skipped)
endif

if expand("$VIM_XML_RT")[0] == '$'
  call Skip("$VIM_XML_RT not set!", g:skipped)
endif
