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

" Leader
let mapleader = " "
nmap <Leader><space> :noh<cr>
" Fugitive
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gcommit -v<CR>
nnoremap <Leader>gp :Gpush<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>

" neomake
autocmd! BufWritePost * Neomake

" vim-test
let test#strategy = "dispatch"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
