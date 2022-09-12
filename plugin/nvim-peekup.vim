if exists('g:loaded_peekup')
  finish
endif

"" export interfaces
nnoremap <Plug>PeekupOpen :lua require('nvim-peekup').peekup_open()<CR>
nnoremap <Plug>PeekupPasteBefore :lua require('nvim-peekup').peekup_open('P')<CR>
nnoremap <Plug>PeekupPasteAfter :lua require('nvim-peekup').peekup_open('p')<CR>
nnoremap <Plug>PeekupEmptyRegisters :call PeekupEmptyRegisters()<CR>

"" assign keybindings
if exists('g:peekup_open')
	execute 'nmap ' . g:peekup_open . ' <Plug>PeekupOpen'
else
	nmap "" <Plug>PeekupOpen
endif

if exists('g:peekup_paste_after')
	execute 'nmap' . g:peekup_paste_after .  ' <Plug>PeekupPasteAfter'
endif

if exists('g:peekup_paste_before')
	execute 'nmap' . g:peekup_paste_before .  ' <Plug>PeekupPasteBefore'
endif

if exists('g:peekup_empty_registers')
	execute 'nmap' . g:peekup_empty_registers .  ' <Plug>PeekupEmptyRegisters'
else
	nmap "x <Plug>PeekupEmptyRegisters
endif

"" define functions
augroup PeekAutoClose
	autocmd!
	autocmd WinLeave * call s:PeekClose()
augroup END

function s:PeekClose() abort
	for i in range(1, winnr('$'))
        if getbufvar(winbufnr(i), '&filetype') ==? 'peek'
			close
		endif
    endfor
endfunction

function PeekupEmptyRegisters() abort
	for i in range(34,122)
		silent! call setreg(nr2char(i), [])
	endfor
endfunction

let g:loaded_peekup = 1
