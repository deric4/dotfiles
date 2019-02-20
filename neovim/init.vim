call plug#begin('~/.local/share/nvim/plugged')

Plug 'PProvost/vim-ps1'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'airblade/vim-gitgutter'
Plug 'buoto/gotests-vim'
Plug 'cespare/vim-toml'
Plug 'dhruvasagar/vim-table-mode'
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'fatih/molokai'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'fatih/vim-hclfmt'
Plug 'fatih/vim-nginx' , {'for' : 'nginx'}
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-hashicorp-tools'
Plug 'maralla/vim-toml-enhance'
Plug 'pearofducks/ansible-vim'
Plug 'tpope/vim-fugitive'

call plug#end()

"=====================================================
"===================== SETTINGS ======================

set ttyfast

set laststatus=2
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set smartindent
set mouse=""
set number
set scrolloff=20
set splitright
set splitbelow
set autowrite
set noswapfile
set nobackup
set ignorecase
set completeopt=menu,menuone
set nocursorcolumn
set nocursorline
set updatetime=300
set pumheight=10
set nowrap

set lazyredraw

" increase max memory to show syntax highlighting for large files 
set maxmempattern=20000

" color
syntax enable
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

augroup filetypedetect
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.hcl setf conf
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.html setlocal noet ts=4 sw=4
  autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.hcl setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.sh setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.proto setlocal expandtab shiftwidth=2 tabstop=2
  autocmd BufNewFile,BufRead *.yaml,*.yml setlocal expandtab shiftwidth=2 tabstop=2

  "kubectl conf
  autocmd BufNewFile,BufRead *.kube/config setlocal expandtab shiftwidth=2 tabstop=2

  "set gitconfig syntax for include files
  autocmd BufNewFile,BufRead .gitconfig* setf gitconfig

  "set Pipfile syntax
  autocmd BufNewFile,BufRead Pipfile setf toml

  "set sshconfig syntax for ssh.cfg used for ansible
  autocmd BufNewFile,BufRead ssh.cfg setf sshconfig

  autocmd BufNewFile,BufRead .yamllint setf yaml

  "ansible
  autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
  autocmd BufRead,BufNewFile */roles/*.yml set filetype=yaml.ansible
  autocmd BufRead,BufNewFile */molecule/*.yml set filetype=yaml.ansible
  autocmd BufRead,BufNewFile */tasks/*.yml set filetype=yaml.ansible

augroup END

"=====================================================
"===================== MAPPINGS ======================

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","

" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

" put quickfix window always to the bottom
augroup quickfix
    autocmd!
    autocmd FileType qf wincmd J
    autocmd FileType qf setlocal wrap
augroup END

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Center the screen
nnoremap <space> zz

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
nnoremap j gj
nnoremap k gk

" Mappings between splits.
map <C-J> <C-W>j<C-W>
map <C-K> <C-W>k<C-W>
map <C-L> <C-W>l<C-W>
map <C-H> <C-W>h<C-W>

" Exit on j
inoremap jk <Esc>

" Act like D and C
nnoremap Y y$

" Do not show stupid q: window
map q: :q

" Clear the search buffer when hitting return
nnoremap <cr> :nohlsearch<cr>

" Cycle buffers
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
if !has('gui_running')
  set notimeout
  set ttimeout
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" reselectp pastecape in insert mod content
noremap gV `[v`]

"Toggle between Fixed and Relative line numbers Ctrl-n"
"Disabled relative line numbers to try and decrease lag
nnoremap <C-n> :call NumberToggle()<cr>
    function! NumberToggle()
      if(&number == 1)
"     if(&relativenumber == 1)
"          set norelativenumber
          set nonumber
      else
"         set relativenumber
          set number
      endif
    endfunc

" Open files where we left off
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
endif

"=====================================================
"===================== PLUGINS ====================

let g:deoplete#enable_at_startup = 1

" ==================== tpope/fugitive =============
vnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gb :Gblame<CR>

" ==================== vim-json ====================
let g:vim_json_syntax_conceal = 0

" ============= pearofducks/ansible-vim ============
let g:ansible_unindent_after_newline = 1
let g:ansible_attribute_highlight = "ab"
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1
"let g:ansible_normal_keywords_highlight = 'Constant'
"let g:ansible_with_keywords_highlight = 'Constant'

" =========== hashivim/vim-hashicorp-tools =========
let g:terraform_fmt_on_save=1
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1

" ================= fatih/vim-go =====================
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_operators = 1

augroup go
  autocmd!

  " :GoTests (not vim-go)
  autocmd FileType go nmap <leader>t  :GoTests<CR>

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b  :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  "autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <leader>d  <Plug>(go-doc)

  " :GoDocBrowser
  autocmd FileType go nmap <leader>f  <Plug>(go-doc-browser)

  " :GoInfo
  autocmd FileType go nmap <leader>i  <Plug>(go-info)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)

  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
augroup END

" ================= fatih/vim-hclfmt =================
let g:hcl_fmt_autosave = 1

" ================= scrooloose/nerdtree ==============
" toggle nerdtree. if opening nerdtree place cursor in main window.
nnoremap <leader>g :nerdtreetoggle \| :wincmd p<cr>

" if closing a buffer while nerdtree is open and nerdtree is the only
" buffer left, exit nerdtree. this prevents having to close 2 times.
autocmd bufenter * if (winnr("$") == 1 && exists("b:nerdtree") && b:nerdtree.istabtree() ||   &buftype == 'quickfix') | q | endif

" ================= valoric/youcompleteme ==============
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']

" ================= dhrusvasagar/vim-table-mode ========
let g:table_mode_corner="|"
nnoremap <leader>tm :TableModeToggle<CR>
