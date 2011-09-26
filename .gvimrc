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

" highlight after 80 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

let $PATH = '/opt/crosstool/mingw32/gcc-3.4.2/bin:/opt/crosstool/mips-linux-uclibc/gcc-4.5.0-uClibc-0.9.30.2/bin:/opt/crosstool/i386-linux-uclibc/gcc-4.5.0-uClibc-0.9.30.2/bin:/opt/crosstool/i686-linux-uclibc/gcc-4.5.0-uClibc-0.9.30.2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games'

" Pathogen
call pathogen#infect()

"set makeprg=g++\ \-Wall\ -o\ %<\ %
"set makeprg=gcc\ \-Wall\ -o\ %<\ %
set autochdir
set switchbuf=useopen,split
set nocompatible
set nocp " non vi compatible mode
"set makeprg=make

set backup
set backupdir=/tmp      " backup dir
set directory=/tmp      " swap file directory

set incsearch
"set hlsearch
set expandtab
set textwidth=80
set lines=60
set tabstop=8
set softtabstop=4
set shiftwidth=4
"set autoindent
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
let Tlist_WinWidth = 50

autocmd FileType python set omnifunc=pythoncomplete#Complete
filetype plugin on
filetype plugin indent on

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction


nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
imap <C-tab> <Esc>:tabnext<CR>i
map <C-t> <Esc>:NERDTreeToggle<CR>
:map <C-c> :tabclose<CR>

map T :TaskList<CR>
map <C-P> :TlistToggle<CR> 
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

nmap <C-s> :w<CR>
nmap <C-c> :make!<CR>
nmap <F4> :!cd .. && ./main<CR>
nmap <F5> :!cd .. && ./editor<CR>
nmap <F3> :!./%<<CR>
nmap <F6> :!./%<CR>
imap <C-s> <Esc>:w<CR>a

nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>
nmap <silent> ,ev :e $MYGVIMRC<CR>

" Tabularize
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif


" MINIBUFEXP
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

" NERDTree
let NERDTreeShowBookmarks = 1

autocmd Bufwritepre,filewritepre *.cpp exe "normal ma"
autocmd Bufwritepre,filewritepre *.cpp exe "1," . 5 . "g/Last Modified:.*/s/Last Modified: .*/Last Modified: " .strftime("%d-%m-%Y %H:%M:%S")
autocmd Bufwritepre,filewritepre *.cpp exe "normal `a"

autocmd Bufwritepre,filewritepre *.h exe "normal ma"
autocmd Bufwritepre,filewritepre *.h exe "1," . 5 . "g/Last Modified:.*/s/Last Modified: .*/Last Modified: " .strftime("%d-%m-%Y %H:%M:%S")
autocmd Bufwritepre,filewritepre *.h exe "normal `a"

"au BufRead,BufNewFile *.cpp 0r ~/.vim/templates/c.vim
au BufRead,BufNewFile *.viki set ft=viki
au BufRead,BufNewFile *.c set makeprg=gcc\ \-Wall\ %\ -o\ %<
au BufRead,BufNewFile *.cpp set makeprg=g++\ \-Wall\ \-g\ %\ -o\ %<
au BufRead,BufNewFile **/book/**.cpp set makeprg=g++\ \-Wall\ \-g\ %\ -o\ %<
au BufRead,BufNewFile **/uni/**.cpp set makeprg=g++\ \-Wall\ \-g\ %\ -o\ %<
au BufRead,BufNewFile **/lua/**.cpp set makeprg=g++\ \-Wall\ \-g\ \-lluabind\ \-llua\ %\ -o\ %<
au BufRead,BufNewFile **/sdl/**.cpp set makeprg=g++\ \-g\ \-lSDL\ \-lSDL_image\ \-lSDL_ttf\ \-lSDL_mixer\ -o\ %<\ %
au BufRead,BufNewFile **/sdl/rogue/**.cpp set makeprg=make\ -C\ ..\/build\/
au BufRead,BufNewFile **/sdl/LD20/**.cpp set makeprg=make\ -C\ ..\/build\/

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
set tags+=~/.vim/tags/stl

function! ToggleIndentGuides()
    if exists('b:indent_guides')
        call matchdelete(b:indent_guides)
        unlet b:indent_guides
    else
        let pos = range(1, &l:textwidth, &l:shiftwidth)
        call map(pos, '"\\%" . v:val . "v"')
        let pat = '\%(\_^\s*\)\@<=\%(' . join(pos, '\|') . '\)\s'
        let b:indent_guides = matchadd('CursorLine', pat)
    endif
endfunction
