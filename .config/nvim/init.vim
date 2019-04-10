call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tomlion/vim-solidity'
Plug 'w0rp/ale'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tomasr/molokai'
Plug 'wincent/terminus'
Plug 'leafgarland/typescript-vim'
call plug#end()

set termguicolors
colorscheme molokai

let mapleader = ","
nnoremap <leader><space> :noh<cr>

nnoremap <leader>ge :e $MYVIMRC<cr>

iabbr @@ Kostis Karantias <kkarantias@gmail.com>

set ignorecase
set smartcase

nnoremap * *N
vnoremap * y<esc>/\V<c-r>"<cr>N

nnoremap / /\v
nnoremap ? ?\v

nnoremap n nzz
nnoremap N Nzz

cmap w!! w !sudo tee > /dev/null %

set cinoptions=g2,h2

" ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_python_auto_pipenv = 1
let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_fix_on_save = 1

" fzf
let g:fzf_buffers_jump = 1
nnoremap <leader>f :GitFiles<cr>

function! SetupLatex()
    ALEDisable
    setl spell
    setl linebreak

    " TODO: should write a function to exchange two keys instead of doing this
    " manually
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
    nnoremap <buffer> 0 g0
    nnoremap <buffer> $ g$
    nnoremap <buffer> gj j
    nnoremap <buffer> gk k
    nnoremap <buffer> g0 0
    nnoremap <buffer> g$ $
endfunction

augroup tex_stuff
    autocmd!
    autocmd FileType tex call SetupLatex()
    autocmd FileType plaintex setl ft=tex
augroup END

au FileType go let b:ale_fixers = ['goimports']
