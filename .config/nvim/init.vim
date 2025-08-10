set number
colorscheme onehalfdark

let mapleader = ";"

" Key mappings
inoremap jj <ESC>
inoremap jk <ESC>

" Disable search
nnoremap <silent><ESC> :nohlsearch<CR>

" Visual line movement when wrapped 
nmap j gj
nmap k gk

" Keymaps for system clipboard
nmap Y "+y
vmap Y "+y
nmap <leader>p "+p

nmap <leader>bd :bdelete<CR>
