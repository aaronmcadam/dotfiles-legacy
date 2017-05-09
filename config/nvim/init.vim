if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim
endif

" Theme
syntax enable
set termguicolors
colorscheme OceanicNext
set background=dark
set colorcolumn=80
" set cursorcolumn
" set cursorline 

" Numbers
set number
set relativenumber
" Set relativenumber for netrw buffers
let g:netrw_bufsettings = "noma nomod nu nobl nowrap ro"
" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir="rm -r"

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

" Bindings
cabbrev X x
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

nnoremap <Leader>wd :Dispatch npm run test:e2e -s<CR>

" fzf.vim
let g:fzf_nvim_statusline = 0 " disable statusline overwriting

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tabe'
      \ }
nnoremap <c-p> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>. :Lines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>
nnoremap <silent> K :call SearchWord()<CR>
vnoremap <silent> K :call SearchVisualSelection()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" Use ripgrep over Grep
set grepprg=rg\ --vimgrep

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! SearchWord()
  execute 'Rg' expand('<cword>')
endfunction

function! SearchVisualSelection() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Rg' selection
endfunction

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

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

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" https://github.com/christoomey/vim-tmux-navigator#it-doesnt-work-in-neovim-specifically-c-h
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

let g:airline_powerline_fonts = 1

let test#javascript#runner = 'jest'

" autocmd FileType javascript set formatprg=prettier-eslint\ --stdin
" autocmd BufWritePre *.js :normal gggqG
nnoremap <Leader>f :Neoformat<CR>
let g:neoformat_javascript_prettiereslint = {
            \ 'exe': 'prettier-eslint',
            \ 'args': ['--stdin', '--prettier.print-width 80'],
            \ 'stdin': 1,
            \ }
let g:neoformat_enabled_javascript = ['prettiereslint']
let g:projectionist_heuristics = {  
            \ "*.js": {
            \   "*.js": {
            \     "alternate": "{}.test.js",
            \     "type": "source"
            \   },
            \   "*.test.js": {
            \     "alternate": "{}.js",
            \     "type": "test"
            \   },
            \   "*.stories.js": {
            \     "alternate": "{}.js",
            \     "type": "doc"
            \   },
            \ }}
