inoremap jk <ESC>
nnoremap <C-l> :tabnext<CR> 
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-PageDown> :+tabmove<CR> 
nnoremap <C-PageUp> :-tabmove<CR> 
nnoremap ; :
vnoremap ; :
noremap j gj
noremap k gk
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $
noremap m  %
nnoremap <PageDown> A<CR><ESC>
nnoremap <PageUp> kA<CR><ESC>
nnoremap <Down> <C-d>
nnoremap <Up> <C-u>

let mapleader = " "
set expandtab
set tabstop=4
set shiftwidth=4
set completeopt=menuone
set foldmethod=syntax 

" netrw
filetype plugin indent on
let g:netrw_browse_split = 3
let g:netrw_banner = 0
let g:netrw_liststyle = 1

" clang-format
autocmd FileType c,cpp,objc map <buffer><Leader>f<Plug>(operator-clang-format)

" neovim-qt
let g:guifont = 'Cascadia Code:h11'

set encoding=utf-8
set clipboard=unnamedplus
set nowrap
let g:python3_host_prog = '/usr/bin/python'
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
runtime! plugins/dein.rc.vim

" python version
let g:python3_host_prog = "/usr/bin/python3.10"
