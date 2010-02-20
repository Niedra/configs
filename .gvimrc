syntax on
set encoding=utf-8
set number
set guioptions=aegirLt
set gfn=Envy\ Code\ R\ 10
colorscheme wombat256

set nocompatible
set makeprg=gcc\ -o\ %<\ %
set autochdir

set incsearch
set expandtab
set textwidth=79
set lines=60
set tabstop=8
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
filetype plugin indent on

nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
imap <C-tab> <Esc>:tabnext<CR>i
nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>
:map <C-c> :tabclose<CR>

map T :TaskList<CR>
map <C-P> :TlistToggle<CR> 

nmap <C-s> :w<CR>
nmap <C-c> :make<CR>
imap <C-s> <Esc>:w<CR>a


