if exists("b:current_syntax")
  finish
endif

for s:section in ['Numerical', 'Literal', 'Special']
	execute 'syntax match RegName' . s:section . ' /^' . s:section . '/ contained'
	execute 'syntax match Reg' . s:section . ' /^' . s:section . '.*/ contains=RegName' . s:section
	execute 'highlight default link RegName' . s:section . ' Title'
	execute 'highlight default link Reg' . s:section . ' Label'
endfor
unlet s:section

execute 'syntax match RegTitle /^\s*' . luaeval("require('nvim-peekup.config').geometry[\"title\"]") . '/'
syntax match RegName /^[\/0-9A-Za-z*+.%-]/ contained
syntax match RegNamePrefix /^[\/0-9A-Za-z*+.%-]:/ contains=RegName

highlight default link RegTitle Title
highlight default link RegNamePrefix Label
highlight default link RegName Tag

let b:current_syntax = "peekup"
