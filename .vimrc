syntax on
filetype plugin on
filetype plugin indent on

let mapleader=","
let g:mapleader=","
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_WinWidth = 50

set encoding=utf-8
set number
set guioptions=aegirLt
set t_Co=256
colorscheme mustang

" highlight after 80 chars
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

if filereadable("~/.vimrc.work")
    source ~/.vimrc.work
endif

set autochdir
set switchbuf=useopen,split
set nocompatible
set nocp " non vi compatible mode
set makeprg=make\ -j\ ARCH=mips

set ignorecase
set smartcase
set title
set scrolloff=3

set undofile
set undodir=/tmp
set backup
set backupdir=/tmp      " backup dir
set directory=/tmp      " swap file directory

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

let g:Powerline_symbols='fancy'

map T :TaskList<CR>
map <C-P> :TlistToggle<CR> 
map <F8> :!ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

nmap <C-c> :make!<CR>
nmap <F4> :!make ARCH=host<CR>
nmap <F5> :make ARCH=mips install PREFIX=$PWD/X<CR>
nmap <F3> :!./%<<CR>
nmap <F9> :!g++ -Wall -g -o %< %<CR>
nmap <F6> :!./%<CR>

nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

map <Leader>v <Plug>TaskList
map <silent> <Leader>n :silent :nohlsearch<CR>
nmap <silent> <Leader>s :w<CR>
nmap <silent> <Leader>q :q<CR>
nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>f :execute "grep --color " . expand('<cword>') . " *"<CR>


" Tabularize
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" Command-T
let g:CommandTMaxFiles = 100000
set wildignore+=*.o,*.d,.git,*.pd

"" -- OmniCpp --
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
" -- ctags --
" set tags=./tags;$HOME
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

au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

" Pathogen
call pathogen#infect()

" Sessions
let g:session_autosave='yes'

" Cscope
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

" Easier window management
nmap <left>  :3wincmd <<cr>
nmap <right> :3wincmd ><cr>
nmap <up>    :3wincmd +<cr>
nmap <down>  :3wincmd -<cr>
