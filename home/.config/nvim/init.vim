call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'ctrlpvim/ctrlp.vim'

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-commentary'

Plug 'christoomey/vim-tmux-navigator'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'unblevable/quick-scope'

Plug 'SirVer/ultisnips'
Plug 'Raimondi/delimitMate'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

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
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_term_enabled = 0
let g:go_term_mode = "split"
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_operators = 0
let g:go_highlight_build_constraints = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file']
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])

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

" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" ==================== UltiSnips ====================
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction

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


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

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

au FileType go nmap <leader>s <Plug>(go-def-split)
au FileType go nmap <leader>v <Plug>(go-def-vertical)

au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>m <Plug>(go-imports)
au FileType go nmap <leader>l <Plug>(go-metalinter)

au FileType go nmap <leader>r  <Plug>(go-run)

au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <leader>t  <Plug>(go-test)
au FileType go nmap <leader>d <Plug>(go-doc)
au FileType go nmap <leader>c <Plug>(go-coverage)

" vim:ts=2:sw=2:et
