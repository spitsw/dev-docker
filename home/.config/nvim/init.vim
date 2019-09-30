
runtime plugins.vim
runtime golang.vim
runtime coc.vim

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
set encoding=utf-8
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set cursorline
set mouse=a
set lazyredraw

set pumheight=10             " Completion window max size

set termguicolors

let mapleader = ","
let g:mapleader = ","

" Remove search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" ==================== lightline = ====================
let g:lightline = {
  \ 'colorscheme': 'hybrid',
  \ 'active': {
  \   'left': [[ 'mode', 'paste' ],
  \            [ 'fugitive', 'cocstatus', 'filename', 'readonly', 'modified'],
  \            [ 'go' ]],
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'fugitive': 'LightLineFugitive',
  \   'modified': 'LightLineModified',
  \   'go': 'LightLineGo'
  \ }
  \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

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

" =================== EditorConfig ==================
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ======================= FZF =======================
nmap <silent> ; :Buffers<cr>
nmap <silent> <leader>t :Files<cr>
nmap <silent> <leader>g :Ag<cr>

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T'] " unblevable/quick-scope

set signcolumn=yes
set updatetime=250

set background=dark
colorscheme hybrid

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
set listchars=tab:▸\ ,eol:¬,extends:>,precedes:<,nbsp:~

highlight Comment gui=italic
highlight Statement gui=italic

" vim:ts=2:sw=2:et
