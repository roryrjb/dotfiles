set nocompatible
set clipboard=unnamed
set cursorline
set incsearch
set hlsearch
set textwidth=0
set wildmenu
set wildoptions+=pum
set undodir=~/vimfiles/undo
set undofile
set noswapfile
set nobackup
set laststatus=2
set path=**
set formatoptions+=j
set autoread
set wrap
set titlestring=%{substitute(getcwd(),\ 'C:\\\\Users\\\\rory',\ '~',\ '')}
set hidden
set guicursor+=a:blinkon0
set list
set listchars=tab:\|-
set scrolloff=8
set grepprg=rg\ --vimgrep
set wildcharm=<tab>

let $PATH .= ";C:\\Program Files\\Sublime Merge\\Git\\cmd"

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'romainl/vim-cool'
Plug 'airblade/vim-rooter'
Plug 'Tetralux/odin.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'
Plug 'dense-analysis/ale'
Plug 'petobens/poet-v'
Plug 'mhartington/oceanic-next'
call plug#end()

let g:sneak#label = 0
" let g:highlightedyank_highlight_in_visual = 0
let g:highlightedyank_highlight_duration = 205

augroup vimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l* lwindow
  autocmd FileType qf setlocal nobuflisted nowrap nonumber norelativenumber
  autocmd FileType json setlocal formatprg=jq\ -r\ .
  autocmd FileType md setlocal shiftwidth=2 tabstop=2 expandtab
  autocmd ColorScheme * highlight Sneak gui=underline guibg=#d75f87
        \ | highlight SneakLabel gui=underline guibg=#d75f87
        \ | highlight SneakLabelMask gui=underline guibg=#d75f87
augroup END

colorscheme OceanicNext

if has("gui_running")
  set guifont=Liberation_Mono:h11
  set guioptions=Ace
  set lines=50
  set columns=170
endif

let undodir = expand("~/vimfiles/undo")

if !isdirectory(undodir)
  call mkdir(undodir, "p")
endif

set wildignore+=*/node_modules/*,*/dist/*,*/build/*,*/.yarn/*,*/.nuxt/*,*/.git/*
set wildignore+=node_modules/*,dist/*,build/*,.yarn/*,.nuxt/*,.git/*
set wildignore+=node_modules,dist,build,.yarn,.nuxt,.git
set wildignore+=*/update_info/*,*/update_parsed_info/*
set wildignore+=*/static/monaco-editor/*,*/test/mock-data/*
set wildignore+=*/.ruff_cache,*/.ruff_cache/*
set wildignore+=tags,*.pyc

function! PopulateGrep(word)
  return ':Grep -w ' . a:word
endfunction

function! Grep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep cexpr Grep(<f-args>)

nnoremap <expr> <leader>a PopulateGrep(expand("<cword>"))
nnoremap <c-p> :find<space>
nnoremap <c-f> :Grep<space>
nnoremap <leader>c :Cfilter!<space>
nnoremap <silent> <c-j> :try<bar>cnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>cfirst<bar>endtry<cr>
nnoremap <silent> <c-k> :try<bar>cprev<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>clast<bar>endtry<cr>
nnoremap <silent> <c-q> :if empty(filter(getwininfo(), 'v:val.quickfix'))<bar>copen<bar>else<bar>cclose<bar>endif<cr>
nnoremap <leader>g :call job_start(["C:/Program Files/Sublime Merge/smerge.exe", "."])<cr>
nnoremap <leader>b :b<space><tab>
nnoremap <leader>q :bw<space><tab>
nnoremap <leader>t :tselect<space>
nnoremap Y y$
cnoremap <c-a> <Home>
cnoremap <c-v> <c-r>*
nmap q: <nop>
nmap <silent> [d <Plug>(ale_previous_wrap)
nmap <silent> ]d <Plug>(ale_next_wrap)

packadd cfilter

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['eslint', 'prettier'],
      \ 'vue': ['eslint', 'prettier'],
      \ 'typescript': ['eslint', 'prettier'],
      \ 'python': ['ruff_format', 'isort'],
      \ }
