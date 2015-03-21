set nocompatible
set modelines=0     " CVE-2007-2438

" Leader
let mapleader = ","

" Numbers
set number
set relativenumber
set numberwidth=5
let g:netrw_bufsettings = "noma nomod nu nobl nowrap ro"

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Include git details in status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Color scheme
set background=dark
colorscheme Tomorrow-Night-Eighties

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

set hlsearch

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

nnoremap \ :Ag<SPACE>

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <Leader><Leader> <c-^>

" Change to the directory of the current file, printing the directory
" after changing, so you know where you ended up
" Source: http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" close all windows
noremap <Leader>q :qall<cr>

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checker = "jshint"
let g:syntastic_ruby_checkers = ["rubocop"]

"" Source the vimrc file after saving it
" if has("autocmd")
"   autocmd bufwritepost .vimrc source ~/.vimrc
" endif

" strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Highlight the current line & column
hi CursorLine ctermbg=236
hi CursorColumn ctermbg=236
set cursorline cursorcolumn

" clear out a search
nnoremap <leader><space> :noh<cr>

" map ; to : for easier saving
nnoremap ; :

" highlight git conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Don't change dir when using Startify links
let g:startify_change_to_dir = 0

" reselect the text that was just pasted
nnoremap <leader>v V`]

"" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Rails.vim Projections
let g:rails_projections = {
\ "app/services/*.rb": {
\   "command": "service",
\   "affinity": "model",
\   "test": "spec/services/%s_spec.rb",
\   "related": "app/models/%s.rb",
\   "template": "class %S\n  def call\n  end\nend"
\ },
\ "app/assets/javascripts/app/services/*.js.coffee": {
\   "command": "jservice",
\   "test": "spec/teaspoon/services/%s_spec.js.coffee",
\   "template": "define ->\n  class %S\n\n"
\},
\ "spec/teaspoon/services/*_spec.js.coffee": {
\   "command": "jsspec",
\   "template": "define ['app/services/%s'], (%S) ->\n  describe 'services/%s', ->",
\   "alternate": "app/assets/javascripts/app/services/%s.js.coffee"
\}}

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

"" Set column marker
highlight ColorColumn guibg=Blue ctermbg=4
set textwidth=80
set colorcolumn=+1

" Fugitive
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit -v<CR>
"" vimdiff current vs git head
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gpf :Git push -f<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>

map <Leader>mv :Rename<space>

nnoremap <Leader>c :TagbarToggle<CR>
let g:neocomplcache_enable_at_startup = 1
let g:user_emmet_leader_key = "<C-E>"

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Location list hack (synastic)
" https://github.com/scrooloose/syntastic/issues/32
function! <SID>LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function! <SID>LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext     :<C-u>exe 'call <SID>LocationNext()'<CR>

function! ReloadChrome()
  wall
  silent :!chrome-cli reload
  redraw!
endfunction
nmap <Leader>rl :call ReloadChrome()<CR>

" Run Rubocop with auto-correct on current file
function! FixRubocopOffences()
  w
  silent :!rubocop % -a
  silent :e!
  redraw!
  echom "Fixable Rubocop Offences auto-corrected."
endfunction
nmap <Leader>ru :call FixRubocopOffences()<CR>
" Show syntastic errors
nmap <Leader>e :Errors<CR>

nmap <Leader>d :Dispatch<space>

" Use octodown for markdown previews
function! PreviewMarkdown()
  w
  silent :!octodown %
  redraw!
endfunction
nmap <Leader>md :call PreviewMarkdown()<CR>

" vim-tmux-runner settings
" Open runner pane to the right, not to the bottom
let g:VtrOrientation = "h"
" Take up 30% of the screen (default is 20%)
let g:VtrPercentage = 30
nmap <Leader>r :VtrSendCommand!<space>
" Attach to a specific pane
nnoremap <Leader>va :VtrAttachToPane<CR>
nmap <leader>fs :VtrFlushCommand<cr>:VtrSendCommandToRunner<cr>
nmap <C-f> :VtrSendLinesToRunner<cr>
vmap <C-f> <Esc>:VtrSendLinesToRunner<cr>
nnoremap <leader>sf :w<cr>:call SendFileViaVtr()<cr>
nnoremap <leader>sl :VtrSendCommandToRunner <cr>

function! SendFileViaVtr()
  let runners = {
        \ 'haskell': 'ghci',
        \ 'ruby': 'ruby',
        \ 'javascript': 'node',
        \ 'python': 'python',
        \ 'sh': 'sh'
        \ }
  if has_key(runners, &filetype)
    let runner = runners[&filetype]
    let local_file_path = expand('%')
    execute join(['VtrSendCommandToRunner', runner, local_file_path])
  else
    echoerr 'Unable to determine runner'
  endif
endfunction

let g:spec_runner_dispatcher = "VtrSendCommand! {command}"
map <Leader>t <Plug>RunCurrentSpecFile
map <Leader>s <Plug>RunFocusedSpec
map <Leader>l <Plug>RunMostRecentSpec
command! RunAllSpecs VtrSendCommand! rspec spec
nnoremap <Leader>a :RunAllSpecs<cr>
map <Leader>p :set paste<CR>
map <Leader>np :set nopaste<CR>
" Bind Dash shortcut
nmap <silent> <Leader>da <Plug>DashSearch

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" open a tmux pane on the right, occupying 50% of the screen, and start `pry`
nnoremap <leader>pry :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'pry'}<cr>

" Diff buffers
nnoremap <Leader>di :window diffthis
" Turn diff mode off
nnoremap <Leader>do :window diffoff

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Pry
nmap <leader>bp orequire "pry"; binding.pry<esc>^

" Capybara show current page in browser
nmap <leader>so osave_and_open_page<esc>^
