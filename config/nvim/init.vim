if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim
endif

" Theme
syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme OceanicNext
set background=dark
set cursorline cursorcolumn
set colorcolumn=80

" Numbers
set number
set relativenumber
" Set relativenumber for netrw buffers
let g:netrw_bufsettings = "noma nomod nu nobl nowrap ro"

" Command-Line mode
set history=200
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Disable mouse click to go to position
set mouse-=a

" Tabs and spaces
" Use spaces instead of tabs
set expandtab
" Manually control tab widths
set nosmarttab
set tabstop=2
" number of spaces to use for autoindenting
set shiftwidth=2
" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround
" strip trailing whitespace on save
autocmd BufWritePre *.rb,*.js,*.coffee,*.css,*.scss :%s/\s\+$//e

" Splits
" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Swap file
set noswapfile

" Add git branch to statusline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " Allow opening multiple splits with same file via CtrlP
  let g:ctrlp_switch_buffer = 0
endif

" Bindings
" Disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" Leader
let mapleader = " "
nmap <Leader><space> :noh<cr>
nnoremap <Leader>q :qa!<CR>

" Tabs
nmap <Leader>tn :tabnext<cr>
nmap <Leader>tp :tabprevious<cr>

" Fugitive
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gcommit -v<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>

" vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_jscs_maker = {
  \ 'exe': 'jscs',
  \ 'args': ['--no-color', '--preset', 'airbnb', '--reporter', 'inline', '--esnext'],
  \ 'errorformat': '%f: line %l\, col %c\, %m',
  \ }
let g:neomake_jsx_jscs_maker = {
  \ 'exe': 'jscs',
  \ 'args': ['--no-color', '--preset', 'airbnb', '--reporter', 'inline', '--esnext'],
  \ 'errorformat': '%f: line %l\, col %c\, %m',
  \ }
let g:neomake_javascript_enabled_makers = ['jscs']
let g:neomake_jsx_enabled_makers = ['jscs']

" vim-test
let test#strategy = "dispatch"
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>s :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
