" scroll_around_cursor.vim - Scroll while keeping the cursor on the same screen line.
" Author: Luc St-Louis <lucs@pobox.com>

" --------------------------------------------------------------------
    " Default mappings.
if ! hasmapto('<Plug>scroll_around_cursorDown')
    map <C-K> <Plug>scroll_around_cursorDown
endif
if ! hasmapto('<Plug>scroll_around_cursorUp')
    map <C-J> <Plug>scroll_around_cursorUp
endif

map <Plug>scroll_around_cursorDown  :call ScrollDown()<CR>
map <Plug>scroll_around_cursorUp    :call ScrollUp()<CR>

" --------------------------------------------------------------------
func! ScrollUp()
    let cur_row = line(".")
    let cursor_is_on_last_screen_row = (cur_row == BotWinRow())
    echo cursor_is_on_last_screen_row . cur_row
    if cur_row != line("$")
        keepjumps normal! j
        if (! cursor_is_on_last_screen_row)
            exe "keepjumps normal! \<C-E>"
        endif
    endif
endfunc

" --------------------------------------------------------------------
func! ScrollDown()
    let cur_row = line(".")
    let cursor_is_on_last_screen_row = (cur_row == BotWinRow())
    if TopWinRow() != 1
        keepjumps exe "normal! \<c-y>"
        if (! cursor_is_on_last_screen_row)
            keepjumps normal! k
        endif
    endif
endfunc

" --------------------------------------------------------------------
func! TopWinRow()
        " Returns the number of the line which is at the top of the
        " window.
    normal! mz
    keepjumps normal! 1H
    let top_row = line(".")
    keepjumps normal! `z
    return top_row
endfunc

" --------------------------------------------------------------------
func! BotWinRow()
        " Returns the number of the line which is at the bottom of the
        " window.
    return TopWinRow() + winheight(0) - 1
endfunc

" vim: ft=help et tw=70 ts=4 sts=4 sw=4

