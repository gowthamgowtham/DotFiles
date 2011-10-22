"
" Plugin to enable changing font size quickly
" See http://vim.wikia.com/wiki/Change_font_size_quickly

" I have customized it to work for Windows 7 also

let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:pattern_win = '^\(.*:\)h\([1-9][0-9]*\)\(:.*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  let fontname = ""
  let cursize = 0
  let extra = ""
  let newsize = 0
  if has("gui_running")
    if has("win32")
      let fontname = substitute(&guifont, s:pattern_win, '\1', '')
      let cursize = substitute(&guifont, s:pattern_win, '\2', '')
      let extra = substitute(&guifont, s:pattern_win, '\3', '')
      let newsize = cursize + a:amount

      if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
        let newfont = fontname . "h" . newsize . extra
        let &guifont = newfont
        redraw | echomsg "Font: " . newfont
      else
        redraw | echomsg "Font size out of range!"
      endif

    else

      let fontname = substitute(&guifont, s:pattern, '\1', '')
      let cursize = substitute(&guifont, s:pattern, '\2', '')
      let newsize = cursize + a:amount

      if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
        let newfont = fontname . newsize
        let &guifont = newfont
        redraw | echomsg "Font: " . newfont
      else
        redraw | echomsg "Font size out of range!"
      endif
    endif
  else
    echoerr "You do not seem to be running a GUI version of vim"
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

" Create maps
map <F7> :call AdjustFontSize( -1 )<CR>
map <F8> :call AdjustFontSize( 1 )<CR>
