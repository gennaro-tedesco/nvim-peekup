echo "nvim-peekup.vim sourced"

nnoremap <leader>q :lua require('nvim-peekup.peekup').peekup_open()<CR>
nnoremap <leader>a :lua require('nvim-peekup.peekup').reg2t()<CR>





