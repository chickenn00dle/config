"""""""""""""""
"Initialization
"""""""""""""""
filetype off
syntax on
filetype plugin indent on
set modelines=0
let mapleader=','

""""""""
"General
""""""""
set backspace=indent,eol,start
set clipboard=unnamed
set encoding=utf8
set foldmethod=indent
set guifont=Menlo\ Regular:h18
set hidden
set list
set listchars=tab:→\ ,trail:•
set matchpairs+=<:>
set mouse=a
set noerrorbells
set nowritebackup
set number
set scrolloff=999
set shellcmdflag=-ic
set signcolumn=yes
set shortmess+=c
set showcmd
set showmode
set showmatch
set title
set ttyfast
set updatetime=300
set visualbell
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
set wildmenu
set wildmode=longest:full,full
set wrap

"""""""""""""""""
"Tabs/Indentation
"""""""""""""""""
set autoindent 
set copyindent
set noexpandtab
set shiftround
set shiftwidth=4
set softtabstop=4
set tabstop=4
set pastetoggle=<F2>

"""""""
"Search
"""""""
set hlsearch
set ignorecase
set incsearch
set path=$PWD/**
set smartcase
set grepprg=grep\ -nrE\ --exclude-dir=.git\ --exclude-dir=dist\ --exclude-dir=i18n\ --exclude-dir=languages\ --exclude-dir=node_modules\ --exclude-dir=vendor
set grepformat+=%f

"""""
"Undo
"""""
set nobackup
set noswapfile
set undofile
set undodir="$XDG_CONFIG_HOME/nvim/undo"
set undolevels=9999

"""""""""""""
"Autocommands
"""""""""""""
"Refresh buffers
au FocusGained,BufEnter * :silent! !
"Open Quickfix window
au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

"""""""""
"Mappings
"""""""""
nnoremap ; :
inoremap jj <Esc>
"Swap panes
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"Move code blocks
nnoremap <S-A-j> :m+<CR>==
nnoremap <S-A-k> :m-2<CR>==
inoremap <S-A-j> <Esc>:m+<CR>==gi
inoremap <S-A-k> <Esc>:m-2<CR>==gi
vnoremap <S-A-j> :m'>+<CR>gv=gv
vnoremap <S-A-k> :m-2<CR>gv=gv
"Space to fold/collapse code blocks
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

""""""""""""""""
"Custom commands
""""""""""""""""
"Find all functions in file
command! Fns execute '/\(^\s*\)[\(public \|private \|protected \|static \)]*function'
"Close all but current buffer
command! BC execute '%bd|e#|bd#|normal! `"'

""""""""
"Plugins
""""""""

if empty(glob("$XDG_CONFIG_HOME/nvim/autoload/plug.vim"))
  silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
Plug 'dense-analysis/ale'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'rizzatti/dash.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-vdebug/vdebug'
call plug#end()

if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""
"Ale
""""
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_fix_on_save = 1
"let g:ale_fixers = {'php': ['phpcbf'], 'javascript': ['eslint']}
let g:ale_linters = {'php': ['phpcs'], 'javascript': ['eslint']}
"let g:ale_php_phpcbf_standard = "WordPress"
"let g:ale_php_phpcbf_use_global = 1
let g:ale_php_phpcs_standard = "WordPress"
let g:ale_php_phpcs_use_global = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
nmap <silent> <leader>an :ALENext<cr>
nmap <silent> <leader>ap :ALEPrevious<cr>

"""""""
"CoCVim
"""""""
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <C-space> coc#refresh()
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

""""
"FZF
""""
map <C-p> :Files<ENTER>

""""""""""
"Gutentags
""""""""""
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = [
	\ 'wp-config.php',
	\ 'package.json',
	\ 'composer.json',
	\ '.git',
	\ 'main.c'
	\ ]
let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags/')
let g:gutentags_ctags_exclude = [
	\ '*.git',
	\ '*.svg',
	\ '*.hg',
	\ '*/tests/*',
	\ 'build',
	\ 'dist',
	\ 'bin',
	\ 'node_modules',
	\ 'cache',
	\ 'docs',
	\ 'bundle',
	\ 'vendor',
	\ '*.md',
	\ '*-lock.json',
	\ '*.lock',
	\ '*bundle*.js',
	\ '*build*.js',
	\ '.*rc*',
	\ '*.json',
	\ '*.min.*',
	\ '*.map',
	\ '*.bak',
	\ '*.zip',
	\ '*.tmp',
	\ '*.cache',
	\ 'tags*',
	\ '*.css',
	\ '*.less',
	\ '*.scss',
	\ '*.exe', '*.dll',
	\ '*.mp3', '*.ogg', '*.flac',
	\ '*.swp', '*.swo',
	\ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
	\ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
	\ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
	\ ]
let g:gutentags_ctags_extra_args = [
	\ '--tag-relative=yes',
	\ '--fields=+ailmnS',
	\ ]
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

"""""""""
"NerdTree
"""""""""
au VimEnter * NERDTree
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeBookmarksFile=expand("$XDG_CONFIG_HOME/nvim/.NERDTreeBookmarks")
let g:NERDTreeDirArrowExpandable='▸'
let g:NERDTreeDirArrowCollapsible='▾'
let g:NERDTreeMinimalUI=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=50
map <C-n> :NERDTreeToggle<CR>
map <C-b> :Bookmark<Space>

"""""""
"Vdebug
"""""""
if !exists('g:vdebug_options')
	let g:vdebug_options={}
endif
let g:vdebug_options['break_on_open']=0
let g:vdebug_options['ide_key']='raz_xdebug'
let g:vdebug_options['port']=9001
let g:vdebug_options['timeout']=30
let g:vdebug_options['simplified_status']=0
let g:vdebug_options['watch_window_style']='expanded' "Set to compact when not dual monitoring
if !exists('g:vdebug_keymap')
	let g:vdebug_keymap={}
endif
let g:vdebug_keymap['run']='<leader>,'
let g:vdebug_keymap['run_to_cursor']='<Down>'
let g:vdebug_keymap['step_over']='<Up>'
let g:vdebug_keymap['step_into']='<Left>'
let g:vdebug_keymap['step_out']='<Right>'
let g:vdebug_keymap['close']='<leader>c'
let g:vdebug_keymap['detach']='<leader>d'
let g:vdebug_keymap['set_breakpoint']='<leader>b'
let g:vdebug_keymap['eval_visual']='<leader>e'
highlight DbgBreakptLine ctermbg=none ctermfg=none
highlight DbgBreakptSign ctermbg=none ctermfg=10
highlight DbgCurrentLine ctermbg=none ctermfg=none
highlight DbgCurrentSign ctermbg=none ctermfg=9

""""""""""""
"Vim Airline
""""""""""""
let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#tabline#buffers_label=''
let g:airline#extensions#tabline#tabs_label=''
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab

""""""
"Theme
""""""
colorscheme palenight
set background=dark
