"Working dir"
""cd /home/roberts/workspace/c/_tut/
cd /home/roberts/workspace/cpp

syntax on
set encoding=utf-8
set number
set guioptions=aegirLt
set gfn=Envy\ Code\ R\ 10
"colorscheme wombat256
colorscheme mustang


"set makeprg=g++\ \-Wall\ -o\ %<\ %
"set makeprg=gcc\ \-Wall\ -o\ %<\ %
set autochdir
set switchbuf=useopen,usetab,newtab
set nocompatible
set nocp " non vi compatible mode
"set makeprg=make

set backup
set backupdir=/tmp      " backup dir
set directory=/tmp      " swap file directory

set incsearch
set expandtab
set textwidth=80
set lines=60
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set guioptions-=r
set guioptions+=l
set guioptions-=l

set guioptions-=m
"set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P
set statusline=
set statusline+=%3.3n\                       " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}%{&bomb?'/bom':''}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%{exists('loaded_VCSCommand')?VCSCommandGetStatusLine():''} " show vcs status
set statusline+=%{exists('loaded_scmbag')?SCMbag_Info():''} " show vcs status
set statusline+=%=                           " right align
set statusline+=\[%{exists('loaded_taglist')?Tlist_Get_Tag_Prototype_By_Line(expand('%'),line('.')):'no\ tags'}]\   " show tag prototype
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

let Tlist_Ctags_Cmd='/usr/bin/ctags'
autocmd FileType python set omnifunc=pythoncomplete#Complete
filetype plugin on
filetype plugin indent on

nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
imap <C-tab> <Esc>:tabnext<CR>i
map tt :tabnew<CR><ESC>:NERDTreeToggle<RETURN>
map <C-t> <Esc>:NERDTreeToggle<CR>
:map <C-c> :tabclose<CR>

map T :TaskList<CR>
map <C-P> :TlistToggle<CR> 

nmap <C-s> :w<CR>
nmap <C-c> :make!<CR>
nmap <F4> :!./main<CR>
nmap <F3>:set makeprg=make<CR>
imap <C-s> <Esc>:w<CR>a

autocmd Bufwritepre,filewritepre *.cpp exe "normal ma"
autocmd Bufwritepre,filewritepre *.cpp exe "1," . 5 . "g/Last Modified:.*/s/Last Modified: .*/Last Modified: " .strftime("%d-%m-%Y %H:%M:%S")
autocmd Bufwritepre,filewritepre *.cpp exe "normal `a"

autocmd Bufwritepre,filewritepre *.h exe "normal ma"
autocmd Bufwritepre,filewritepre *.h exe "1," . 5 . "g/Last Modified:.*/s/Last Modified: .*/Last Modified: " .strftime("%d-%m-%Y %H:%M:%S")
autocmd Bufwritepre,filewritepre *.h exe "normal `a"

"au BufRead,BufNewFile *.cpp 0r ~/.vim/templates/c.vim
au BufRead,BufNewFile *.viki set ft=viki
au BufRead,BufNewFile *.c set makeprg=gcc\ \-Wall\ %\ -o\ %<
au BufRead,BufNewFile *.cpp set makeprg=g++\ \-Wall\ %\ -o\ %<
au BufRead,BufNewFile **/book/**.cpp set makeprg=g++\ \-Wall\ %\ -o\ %<
au BufRead,BufNewFile **/sdl/**.cpp set makeprg=g++\ \-lSDL\ \-lSDL_image\ \-lSDL_ttf\ -o\ %<\ %
au BufRead,BufNewFile **/sdl/rogue/**.cpp set makeprg=make

" OmniCpp
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone
" -- configs --
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
" -- ctags --
" map <ctrl>+F12 to generate ctags for current folder:
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" add current directory's generated tags file to available tags
set tags+=./tags
