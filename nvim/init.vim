"""""""""""""""
"Initialization
"""""""""""""""
syntax on
filetype plugin indent on
let mapleader=','
colorscheme custom


""""""""
"General
""""""""
set backspace=indent,eol,start
set clipboard=unnamed
set completeopt=menu,menuone,noinsert,noselect
set cursorline
set encoding=utf8
set foldmethod=indent
set guifont=Menlo\ Regular:h18
set hidden
set list
set listchars=tab:→\ ,trail:•
set matchpairs+=<:>
set modelines=0
set mouse=a
set noerrorbells
set noshowmode
set nowritebackup
set number
set scrolloff=999
set shellcmdflag=-ic
set signcolumn=yes
set shortmess+=c
set showcmd
set showmatch
set title
set updatetime=300
set visualbell
set wildignore=dist/*,vendor/*,node_modules/*,.git/*
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


"""""""
"Search
"""""""
set hlsearch
set ignorecase
set incsearch
set path=$PWD/**
set smartcase


"""""
"Undo
"""""
set nobackup
set noswapfile
set undofile
set undodir="$XDG_CONFIG_HOME/nvim/undo"
set undolevels=9999


"""""""""
"Key Maps
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


""""""""
"Plugins
""""""""
"Install Plugged if not already installed
if empty(glob("$XDG_CONFIG_HOME/nvim/autoload/plug.vim"))
	silent !curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("$XDG_CONFIG_HOME/nvim/plugged")
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'preservim/nerdtree'
	Plug 'Shougo/denite.nvim', {'do': ':UpdateRemotePlugins'}
	Plug 'tomtom/tcomment_vim'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-rhubarb'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-vinegar'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'vim-scripts/matchit.zip'
	Plug 'vim-vdebug/vdebug'
	"Language Servers
	Plug 'iamcco/diagnostic-languageserver', {'do': 'yarn install --frozen-lockfile && yarn build'}
	Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
	Plug 'marlonfan/coc-phpls', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
	Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

"Install any uninstalled plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	au VimEnter * PlugInstall --sync | source $MYVIMRC
endif


""""""""
"Airline
""""""""
let g:airline_theme='minimalist'
let g:airline#extensions#ale#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline#extensions#tabline#buffers_label=''
let g:airline#extensions#tabline#tabs_label=''
let g:airline#extensions#tabline#buffer_idx_mode=1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab


""""
"CoC
""""
inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-Space> coc#refresh()
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() :
	\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent> gh :call <SID>show_documentation()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gn :call CocAction('diagnosticNext')<CR>
nmap <silent> gp :call CocAction('diagnosticPrevious')<CR>

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
function! s:show_documentation()
	if &filetype == 'vim'
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction


"""""""
"Denite
"""""""
call denite#custom#option( '_', 'auto_resize', 1 )
call denite#custom#option( '_', 'highlight_matched_char', 'QuickFixLine' )
call denite#custom#option( '_', 'highlight_matched_range', 'Visual' )
call denite#custom#option( '_', 'source_names', 'short' )
call denite#custom#option( '_', 'split', 'floating' )
call denite#custom#option( '_', 'vertical_preview', 1 )
call denite#custom#option( '_', 'winrow', 1 )
call denite#custom#var( 'buffer', 'date_format', '' )
call denite#custom#var( 'file/rec', 'command', [
	\	'scantree.py', '--path', ':directory',
	\	"--ignore='.git,node_modules,vendor'" ] )
call denite#custom#var( 'grep', {
	\ 'command': [ 'grep' ],
	\ 'default_opts': [ '-inH' ],
	\ 'recursive_opts': [
	\	'-r',
	\	'--exclude-dir=dist',
	\	'--exclude-dir=vendor',
	\	'--exclude-dir=node_modules',
	\	'--exclude-dir=\*git',
	\	'--exclude-dir=docs',
	\	'--exclude-dir=packages',
	\	'--exclude=*.lock',
	\	'--exclude=*.md',
	\	'--exclude=*.txt',
	\	'--exclude=*.pot',
	\	'--exclude=*.zip',
	\ ],
	\ 'pattern_opt': [ '-e' ],
	\ 'separator': [ '--' ],
	\ 'final_opts': [] } )

nmap <C-b> :Denite buffer<CR>
nmap <C-p> :DeniteProjectDir file/rec<CR>
nnoremap <C-g> :<C-u>Denite grep:. -no-empty<CR>
nnoremap <C-f> :<C-u>DeniteCursorWord grep:.<CR>

autocmd FileType denite call s:denite_my_settings()

function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR>
		\ denite#do_map('do_action')
	nnoremap <silent><buffer><expr> d
		\ denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p
		\ denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> q
		\ denite#do_map('quit')
	nnoremap <silent><buffer><expr> i
		\ denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Space>
		\ denite#do_map('toggle_select').'j'
endfunction


"""""""""
"NerdTree
"""""""""
au VimEnter * NERDTree
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
au FileType nerdtree set norelativenumber

let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeBookmarksFile=expand("$XDG_CONFIG_HOME/nvim/.NERDTreeBookmarks")
let g:NERDTreeDirArrowExpandable='▸'
let g:NERDTreeDirArrowCollapsible='▾'
let g:NERDTreeMinimalUI=1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=50
let &fcs='eob: '

map <leader>n :NERDTreeToggle<CR>
map <leader>b :Bookmark<Space>

augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end


"""""""
"Vdebug
"""""""
let g:vdebug_options={}
let g:vdebug_options['break_on_open']=0
let g:vdebug_options['ide_key']='raz_xdebug'
let g:vdebug_options['port']=9001
let g:vdebug_options['timeout']=30
let g:vdebug_options['simplified_status']=0
let g:vdebug_options['watch_window_style']='expanded' "Set to compact when not dual monitoring

let g:vdebug_keymap={}
let g:vdebug_keymap['run']='<leader>,'
let g:vdebug_keymap['run_to_cursor']='<Down>'
let g:vdebug_keymap['step_over']='<Up>'
let g:vdebug_keymap['step_into']='<Left>'
let g:vdebug_keymap['step_out']='<Right>'
let g:vdebug_keymap['close']='<leader>c'
let g:vdebug_keymap['detach']='<leader>d'
let g:vdebug_keymap['set_breakpoint']='<leader>b'
let g:vdebug_keymap['eval_visual']='<leader>e'
