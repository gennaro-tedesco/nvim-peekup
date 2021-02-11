if exists('g:loaded_peekup')
  finish
endif

nnoremap <Plug>PeekupOpen :lua require('nvim-peekup').peekup_open()<CR>

if exists('g:peekup_open')
	echo g:peekup_open
	execute 'nmap ' . g:peekup_open . ' <Plug>PeekupOpen'
else
	nmap "" <Plug>PeekupOpen
endif

let g:loaded_peekup = 1
