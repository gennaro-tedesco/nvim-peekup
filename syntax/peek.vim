if exists("b:current_syntax")
  finish
endif

for s:section in ['Numerical', 'Literal', 'Special']
	execute 'syntax match Reg' . s:section . ' /^' . s:section . '.*/'
	execute 'highlight default link Reg' . s:section . ' Label'
endfor
unlet s:section

syntax match NumReg /^[0-9]:/
syntax match LitReg /^[A-Za-z]:/

let s:window_title=luaeval('require("nvim-peekup.config").geometry["title"]')
execute 'syntax match WindowTitle /' . s:window_title .'/'

highlight default link NumReg Tag
highlight default link LitReg Tag
highlight default link WindowTitle Label

let b:current_syntax = "peekup"
