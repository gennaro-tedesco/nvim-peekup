if exists('g:loaded_peekup')
  finish
endif

nnoremap <Plug>PeekupOpen :lua require('nvim-peekup').peekup_open()<CR>
nnoremap <Plug>PeekupPasteBefore :lua require('nvim-peekup').peekup_open('P')<CR>
nnoremap <Plug>PeekupPasteAfter :lua require('nvim-peekup').peekup_open('p')<CR>

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

let g:loaded_peekup = 1
