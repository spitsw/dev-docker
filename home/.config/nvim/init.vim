call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'zchee/deoplete-go', { 'do': 'make' }

Plug 'ervandew/supertab'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-commentary'

Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'unblevable/quick-scope'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neomake/neomake'

Plug 'majutsushi/tagbar'

Plug 'w0ng/vim-hybrid'
Plug 'cocopon/lightline-hybrid.vim'

call plug#end()

set noerrorbells             " No beeps
set number                   " Show line number on the current line
set relativenumber           " Show relative numbers
set showcmd                  " Show me what I'm typing
set showmode                 " Show current mode.
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set cursorline

set pumheight=10             " Completion window max size

let mapleader = ","
let g:mapleader = ","

" Remove search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" vim-go
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_auto_type_info = 0
let g:go_echo_command_info = 0
let g:go_async_run = 1

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1

" tagbar
nnoremap <silent> <leader>a :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds' : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" ==================== lightline = ====================
let g:lightline = {
  \ 'colorscheme': 'hybrid',
  \ 'active': {
  \   'left': [[ 'mode', 'paste' ],
  \            [ 'fugitive', 'filename', 'readonly', 'modified', 'ctrlpmark'],
  \            [ 'go' ]],
  \ },
  \ 'inactive': {
  \    'left': [[ 'go' ]],
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'modified': 'LightLineModified',
  \   'ctrlpmark': 'LightLineCtrlPMark',
  \   'go': 'LightLineGo'
  \ }
  \ }

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineGo()
  return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
endfunction

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineCtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

" =================== CtrlP =========================
let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

" ==================== Deoplete =====================
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

" ==================== UltiSnips ====================
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ===================== Neomake =====================
let g:neomake_javascript_enabled_makers = ['eslint_d']
let g:neomake_open_list=2
autocmd! BufWritePost * Neomake

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] " unblevable/quick-scope

let g:gitgutter_sign_column_always = 1
set updatetime=250

set background=dark
colorscheme hybrid
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

set list
set listchars=tab:▸\ ,eol:¬

" Go settings
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>

au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)

au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>p <Plug>(go-implements)
au FileType go nmap <leader>m <Plug>(go-imports)
au FileType go nmap <Leader>l <Plug>(go-metalinter)

au FileType go nmap <leader>r  <Plug>(go-run)

au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <leader>t  <Plug>(go-test)
au FileType go nmap <Leader>d <Plug>(go-doc)
au FileType go nmap <Leader>c <Plug>(go-coverage)

" vim:ts=2:sw=2:et
