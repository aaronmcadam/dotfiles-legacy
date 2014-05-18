let mapleader = ","

" Set highlight for line length
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
set t_Co=256
set background=dark
if !has('gui_running')
  let g:solarized_termcolors=&t_Co
  let g:solarized_termtrans=1
endif
colorscheme solarized

runtime macros/matchit.vim

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc.after source ~/.vimrc.after
endif

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set noswapfile
set spell spelllang=en_gb

" turn off annoying beep
set visualbell
set wrap

" strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Set colour of cursor
hi Cursor guifg=white guibg=black

" Highlight the current line & column
highlight! CursorLine ctermbg=236
highlight! CursorColumn ctermbg=236
set cursorline cursorcolumn

" Set column marker
highlight ColorColumn guibg=Blue ctermbg=4
set colorcolumn=80

set nonumber
set relativenumber
set number
" keymapping stuff

" ctags shortcuts
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" clear out a search
nnoremap <leader><space> :noh<cr>

" show invisible characters and set custom chars for them
set list
set listchars=tab:▸\ ,eol:¬

" map ; to : for easier saving
nnoremap ; :

" highlight git conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" reselect the text that was just pasted to perform commands (like indentation) on it:
nnoremap <leader>v V`]

" open a new vertical split and switch over to it
nnoremap <leader>w <C-w>v<C-w>l

" }}}

" copy full file path to clipboard (+ register)
nnoremap <leader>f :let @+ = expand("%:p")<CR>:let @" = expand("%:p")<CR>

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Surround.vim
" surround a word with spaces
map <leader>i S<space>o<cr>

" NERD Tree {{{
let NERDTreeChDirMode=2
let NERDTreeShowHidden=1
noremap <leader>n <Esc>:NERDTree<space>
noremap  <F6> :NERDTreeToggle<cr>
inoremap <F6> <esc>:NERDTreeToggle<cr>

au Filetype nerdtree setlocal nolist

" Powerline
let g:Powerline_symbols='fancy'

" Syntastic {{{
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checker = "jshint"
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
" }}}

let g:user_zen_expandabbr_key = '<c-y>'
let g:use_zen_complete_tag = 1

" Tabularize
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" vimdiff current vs git head (fugitive extension) {{{2
nnoremap <Leader>gd :Gdiff<cr>
" Close any corresponding diff buffer
function! MyCloseDiff()
  if (&diff == 0 || getbufvar('#', '&diff') == 0)
        \ && (bufname('%') !~ '^fugitive:' && bufname('#') !~ '^fugitive:')
    echom "Not in diff view."
    return
  endif

  " close current buffer if alternate is not fugitive but current one is
  if bufname('#') !~ '^fugitive:' && bufname('%') =~ '^fugitive:'
    if bufwinnr("#") == -1
      b #
      bd #
    else
      bd
    endif
  else
    bd #
  endif
endfunction
nnoremap <Leader>gD :call MyCloseDiff()<cr>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" close all windows
noremap <Leader>q :windo q!<cr>

" shortcut to open file under cursor in vsplit
noremap <F13> :vertical wincmd f<CR>

" NERDCommenter: add a space to the left delimiter
let NERDSpaceDelims=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!spring cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!spring rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!spring rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

map <Leader>r :w<cr>:call RunCurrentTest()<CR>
map <Leader>l :w<cr>:call RunCurrentLineInTest()<CR>

" Split autoresize
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" Rails.vim Projections
let g:rails_projections = {
\ "app/services/*.rb": {
\   "command": "service",
\   "affinity": "model",
\   "test": "spec/services/%s_spec.rb",
\   "related": "app/models/%s.rb",
\   "template": "class %S\n\n  def run\n  end\nend"
\ }}

let g:rails_gem_projections = {
\ "draper": {
\   "app/decorators/*_decorator.rb": {
\     "command": "decorator",
\     "affinity": "model",
\     "test": "spec/decorators/%s_spec.rb",
\     "related": "app/models/%s.rb",
\     "template": "class %SDecorator < Draper::Decorator\nend"
\   }
\ }}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>mv :call RenameFile()<cr>

" vim-run-interactive shortcut
nnoremap <leader>ri :RunInInteractiveShell<space>
