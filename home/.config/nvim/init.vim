
call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'Shougo/deoplete.nvim'
Plug 'vim-airline/vim-airline'
Plug 'benekastah/neomake'

call plug#end()

let g:deoplete#enable_at_startup = 1
