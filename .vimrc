" .vimrc
" vim: foldmethod=marker
" Roberts Niedra


" Preamble ----------------------------------------------------------------- {{{
syntax on
filetype plugin on
filetype plugin indent on
call pathogen#infect()
set nocompatible
" }}}
" Basic options ------------------------------------------------------------ {{{
" Leader
let mapleader=","
let g:mapleader=","

set encoding=utf-8
set number
set guioptions=aegirLt
set t_Co=256
set ttyfast
set visualbell
set lazyredraw

colorscheme mustang

" highlight after 80 chars
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

" Pathogen
call pathogen#infect()

set switchbuf=useopen,split
set nocp " non vi compatible mode
set makeprg=make\ -j

set autowrite
set autoread
set completeopt=longest,menuone,preview
set noautochdir

set ignorecase
set smartcase
set title
set scrolloff=3
set mouse=a

set undofile
set undodir=/tmp
set undoreload=10000
set backup
set noswapfile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

set wildmenu
set wildignore+=*.o,*.d,.git,*.pd,*.bmp

set incsearch
set hlsearch
set expandtab
set textwidth=80
"set lines=60
set tabstop=8
set softtabstop=4
set shiftwidth=4
"set autoindent
set guioptions-=r
set guioptions+=l
set guioptions-=l

set backspace=indent,eol,start

set equalalways

set guioptions-=m
"set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P
set statusline=
set statusline+=%3.3n\                       " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}%{&bomb?'/bom':''}, " encoding
set statusline+=%{&fileformat}]              " file format

set statusline+=%=                           " right align
"set statusline+=\[%{exists('loaded_taglist')?Tlist_Get_Tag_Prototype_By_Line(expand('%'),line('.')):'no\ tags'}]\   " show tag prototype
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

set grepprg=grep\ -sn

set pastetoggle=,p
" }}}
" Include other configs ---------------------------------------------------- {{{
if filereadable("~/.vimrc.work")
    source ~/.vimrc.work
endif
" }}}
" Quick edit --------------------------------------------------------------- {{{
nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>sv :so $MYVIMRC<CR>
" }}}
" Mappings ----------------------------------------------------------------- {{{
nmap <C-c> :make!<CR>
noremap <F1> :set relativenumber<CR>
noremap <F2> :set number<CR>
nmap <F5> :make ARCH=mips install PREFIX=$PWD/X<CR>
nmap <F3> :!./%<<CR>
nmap <F9> :!g++ -Wall -g -o %< %<CR>
nmap <F6> :!./%<CR>

nnoremap <C-H> :Hexmode<CR>
"inoremap <C-H> <Esc>:Hexmode<CR>
"vnoremap <C-H> :<C-U>Hexmode<CR>

map <silent> <Leader>n :silent :nohlsearch<CR>
nmap <silent> <Leader>s :w<CR>
nmap <silent> <Leader>q :q<CR>
nmap <silent> <Leader>f :execute "grep --color " . expand('<cword>') . " *"<CR>
nmap <silent> <Leader>g :execute "grep -R --color " . expand('<cword>') . " *"<CR>

" Easier window management
" nmap <left>  :3wincmd <<cr>
" nmap <right> :3wincmd ><cr>
" nmap <up>    :3wincmd +<cr>
" nmap <down>  :3wincmd -<cr>
" }}}
" File types - Auto commands ----------------------------------------------- {{{
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
au BufRead,BufNewFile *nc setfiletype nc
au BufRead,BufNewFile *nse setfiletype lua
" }}}
" Line numbering ----------------------------------------------------------- {{{
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
" }}}
" Plugin settings ---------------------------------------------------------- {{{
" Tag list ----------------------------------------------------------------- {{{
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_WinWidth = 35

map <C-P> :TlistToggle<CR> 
" map <F8> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
" }}}
" Clang complete ----------------------------------------------------------- {{{
let g:clang_complete_copen=1
let g:clang_periodic_quickfix=0
let g:clang_close_preview=1
" }}}
" CTRLP -------------------------------------------------------------------- {{{
" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr _darcs
" 'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
" 0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_max_height = 30

nnoremap <silent> <Leader>t :CtrlPMixed<CR>
nnoremap <silent> <Leader>v :CtrlPBuffer<CR>
" }}}
" Sessions ----------------------------------------------------------------- {{{
let g:session_autosave='yes'
" }}}
" Cscope ------------------------------------------------------------------- {{{
if has('cscope')
    set cscopetag cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help
endif
" }}}
" Commant-T ---------------------------------------------------------------- {{{
nnoremap <silent> <Leader>v :CommandTBuffer<CR>
let g:CommandTMaxFiles = 100000
" }}}
" OmniCpp ------------------------------------------------------------------ {{{
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"set completeopt=menu,menuone
"
"" -- configs --
"let OmniCpp_MayCompleteDot = 1 " autocomplete with .
"let OmniCpp_GlobalScopeSearch = 1 " autocomplete with .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
"let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
"let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
"let OmniCpp_ShowAccess = 1
"
"function! UPDATE_TAGS()
"  "let _f_ = expand("%:p")
"  let _cmd_ = '"ctags -a -f tags --c++-kinds=+p --fields=+iaS --extra=+q ."'
"  let _resp = system(_cmd_)
"  unlet _cmd_
"  "unlet _f_
"  unlet _resp
"endfunction
"autocmd BufWrite *.cpp,*.h,*.c call UPDATE_TAGS()
" }}}
" Tabularize --------------------------------------------------------------- {{{
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>

  AddTabularPattern struct /\S\+;
endif
" }}}
" Powerline ---------------------------------------------------------------- {{{
let g:Powerline_symbols='fancy'
" }}}
" Powerline ---------------------------------------------------------------- {{{
" }}}
" }}}
" Java --------------------------------------------------------------------- {{{
autocmd Filetype java setlocal omnifunc=javacomplete#Complete
autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
" }}}
