call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'elzr/vim-json', {'for' : 'json'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Styles {{{
Plug 'alexlafroscia/postcss-syntax.vim', { 'for': 'css' }
" }}}

Plug 'junegunn/fzf',  { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'

Plug 'tyru/caw.vim'
Plug 'Shougo/context_filetype.vim'

Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'unblevable/quick-scope'

Plug 'tpope/vim-fugitive'

Plug 'w0ng/vim-hybrid'
Plug 'cocopon/lightline-hybrid.vim'

Plug 'editorconfig/editorconfig-vim'

call plug#end()
