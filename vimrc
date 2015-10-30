set modelines=0     " CVE-2007-2438

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Source the vimrc file after saving it
" if has("autocmd")
"   autocmd bufwritepost .vimrc source ~/.vimrc
" endif

syntax enable
filetype plugin indent on

" Color scheme
set t_Co=256
set background=dark
colorscheme base16-ateliersulphurpool

set autowrite     " Automatically :write before running commands
set autoread      " Reload files changed outside vim
set backspace=2   " Backspace deletes like most programs in insert mode
set cursorline cursorcolumn
hi ColorColumn ctermbg=red
set colorcolumn=+1
" Always use vertical diffs
set diffopt+=vertical
set expandtab
set history=50
set hlsearch
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set list listchars=tab:»·,trail:·
set nobackup
" http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set noswapfile
set nowritebackup
set number
set relativenumber
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
" Open new split panes to right and bottom, which feels more natural
set shiftwidth=2
set shiftround
set splitbelow
set splitright
" Include git details in status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set tabstop=2
set textwidth=80
set wildmode=list:longest,list:full

let g:netrw_bufsettings = "noma nomod nu nobl nowrap ro"

" strip trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" highlight git conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

command! W :w
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
nnoremap \ :Ag<SPACE>
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nmap s ysi
nmap S ysa
nmap SS ys$

let mapleader = " "
nnoremap <Leader><Leader> <c-^>
nmap <Leader><space> :noh<cr>
nnoremap <Leader>a :wall<cr>:RunAllSpecs<cr>
nnoremap <Leader>bp orequire "pry"; binding.pry<esc>^
" Change to the directory of the current file, printing the directory
" after changing, so you know where you ended up
" Source: http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <Leader>ct :!ctags -R .<CR>
imap <Leader>cw @crowdlab-uk/web<space>
nmap <silent> <Leader>da <Plug>DashSearch
nnoremap <Leader>di :windo diffthis<CR>
nnoremap <Leader>so osave_and_open_page<esc>^
nnoremap <Leader>do :windo diffoff<CR>
nnoremap <Leader>e :Errors<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gc :Gcommit -v<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>gpf :Git push -f<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>
"Indent file and return to current line
noremap <Leader>i mmgg=G`m<cr>
nmap <Leader>l <Plug>RunMostRecentSpec
nnoremap <Leader>md :call PreviewMarkdown()<CR>
nnoremap <Leader>mv :Rename<space>
nnoremap <Leader>p :r!pbpaste<cr>
nnoremap <Leader>q :qa!<CR>
nnoremap <Leader>rl :call ReloadChrome()<CR>
nnoremap <Leader>ru :call FixRubocopOffences()<CR>
nmap <Leader>s <Plug>RunFocusedSpec
nmap <Leader>t <Plug>RunCurrentSpecFile
nmap <Leader>tt :tabnew<cr>
nmap <Leader>tc :tabclose<cr>
nmap <Leader>te :tabedit
nmap <Leader>tf :tabfirst<cr>
nmap <Leader>tn :tabnext<cr>
nmap <Leader>tl :tablast<cr>
nmap <Leader>tm :tabmove
nmap <Leader>to :tabonly<cr>
nmap <Leader>tp :tabprevious<cr>
" reselect the text that was just pasted
nnoremap <Leader>v V`]
nnoremap <Leader>w :w<CR>

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

  " Automatically wrap at 80 characters and spell check Markdown
  autocmd FileType markdown setlocal spell
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

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

let g:syntastic_javascript_checkers = ["jshint"]
let g:syntastic_ruby_checkers = ["rubocop"]

" vim-tmux-runner settings
" nmap <leader>fs :VtrFlushCommand<cr>:VtrSendCommandToRunner<cr>
" nmap <C-f> :VtrSendLinesToRunner<cr>
" vmap <C-f> <Esc>:VtrSendLinesToRunner<cr>
" nnoremap <leader>sf :w<cr>:call SendFileViaVtr()<cr>
" nnoremap <leader>sl :VtrSendCommandToRunner <cr>
let g:spec_runner_dispatcher = "VtrSendCommand! {command}"
let g:VtrUseVtrMaps = 1
let g:VtrPercentage = 35
" Mapping      |   Command
" -----------------------------
" <leader>rr   |   VtrResizeRunner<cr>
" <leader>ror  |   VtrReorientRunner<cr>
" <leader>sc   |   VtrSendCommandToRunner<cr>
" <leader>sl   |   VtrSendLineToRunner<cr>
" <leader>or   |   VtrOpenRunner<cr>
" <leader>kr   |   VtrKillRunner<cr>
" <leader>fr   |   VtrFocusRunner<cr>
" <leader>dr   |   VtrDetachRunner<cr>
" <leader>ar   |   VtrReattachRunner<cr>
" <leader>cr   |   VtrClearRunner<cr>
" <leader>fc   |   VtrFlushCommand<cr>
nnoremap <Leader>r :VtrSendCommand!<space>
nmap <Leader>va :VtrAttachToPane<CR>
nnoremap <Leader>sd :VtrSendCtrlD<CR>
nmap <leader>osr :VtrOpenRunner {'orientation': 'h', 'percentage': 50}<CR>
" open a tmux pane on the right, occupying 50% of the screen, and start `pry`
nnoremap <Leader>pry :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'pry'}<CR>

" zoom a vim pane, <C-w>= to re-balance
" nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
" nnoremap <leader>= :wincmd =<cr>

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
xmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

function! FixRubocopOffences()
  w
  silent :!rubocop % -a
  silent :e!
  redraw!
  echom "Fixable Rubocop Offences auto-corrected."
endfunction

function! PreviewMarkdown()
  w
  silent :!octodown %
  redraw!
endfunction

function! ReloadChrome()
  if exists("g:chrome_tab_number")
    silent execute '!chrome-cli reload -t ' . g:chrome_tab_number
  else
    silent execute '!chrome-cli reload'
  end
  wall
  redraw!
endfunction

command! RunAllSpecs VtrSendCommand! rspec spec

" function! SendFileViaVtr()
"   let runners = {
"         \ 'haskell': 'ghci',
"         \ 'ruby': 'ruby',
"         \ 'javascript': 'node',
"         \ 'python': 'python',
"         \ 'sh': 'sh'
"         \ }
"   if has_key(runners, &filetype)
"     let runner = runners[&filetype]
"     let local_file_path = expand('%')
"     execute join(['VtrSendCommandToRunner', runner, local_file_path])
"   else
"     echoerr 'Unable to determine runner'
"   endif
" endfunction

" Completion functionality, unifying supertab, ultisnips, and YouCompleteMe
" via http://stackoverflow.com/a/22253548/1626737

"-----------------------------------------------------------
" YouCompleteMe - Intelligent completion with fuzzy matching
"-----------------------------------------------------------
let g:ycm_dont_warn_on_startup = 0
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

let g:ycm_filetype_blacklist = {}

let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

"--------------------------------------------------
" Supertab - enhanced tab behavior based on context
"--------------------------------------------------
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0

"----------------------------------------
" UltiSnips - Fancy snippet functionality
"----------------------------------------
let g:UltiSnipsSnippetsDir='~/.vim/snippets'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'

nnoremap <leader>ue :UltiSnipsEdit<cr>

function! SpecDescribedClass()
  let spec_name = SpecDescribedClassPath()
  let spec_types = ["lib", "models", "controllers", "services", "mailers",
                   \"helpers", "policies"]
  for path in spec_types
    let spec_name = substitute(spec_name, "^" . path . "/", "", "")
  endfor
  return rails#camelize(spec_name)
endfunction

function! SpecDescribedClassPath()
  let spec_path = substitute(expand("%:r"), "_spec$", "", "")
  let spec_path = substitute(spec_path, "^" . SpecRoot() . "/", "", "")
  let spec_path = substitute(spec_path, "^spec/", "", "")
  return spec_path
endfunction

function! SpecRoot()
  if strlen(RailsRoot()) > 0
    return RailsRoot()
  else
    return getcwd()
  endif
endfunction

function! DefaultFeatureTitle()
  let filename = expand("%:t")
  let without_suffix = substitute(filename, "_spec.rb$", "", "")
  let humanized = substitute(without_suffix, "_", " ", "g")
  let title = Capitalize(humanized)
  return title
endfunction

function! Capitalize(string)
  return substitute(a:string, "^\\w", "\\u\\0", "")
endfunction

nnoremap <Leader>cl :s/,/,\r/g<CR>
