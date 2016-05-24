if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim
endif

" Theme
syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme dracula
set background=dark
set cursorline cursorcolumn
set colorcolumn=80

" Numbers
set number
set relativenumber
" Set relativenumber for netrw buffers
let g:netrw_bufsettings = "noma nomod nu nobl nowrap ro"

" Command-Line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
set hidden
set history=1000
set undolevels=1000 

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
" Leader
let mapleader = " "
nmap <Leader><space> :noh<cr>
nnoremap <Leader>q :qa!<CR>
" reselect the text that was just pasted
nnoremap <Leader>v V`]

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

" fzf.vim
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>. :Lines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction

" vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" neomake
autocmd BufWrite * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
" Taken from https://www.npmjs.com/package/eslint-config-aftership:
" load local eslint in the project root
" modified from https://github.com/mtscout6/syntastic-local-eslint.vim
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" Testing
nnoremap <Leader>bp orequire "pry"; binding.pry<esc>^
nnoremap <Leader>so osave_and_open_page<esc>^
" vim-test
let test#strategy = "dispatch"
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>s :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let test#runners = {'JavaScript': ['Teaspoon']}

autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80
" Spell-check Markdown files
autocmd FileType markdown setlocal spell
" Spell-check Git messages
autocmd FileType gitcommit setlocal spell
set spellfile=$HOME/.config/nvim/vim-spell-en.utf-8.add
" Autocomplete with dictionary words when spell check is on
set complete+=kspell

nmap - :Explore<CR>
