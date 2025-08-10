set number
set undofile

set list

set tabstop=4
set expandtab
set shiftwidth=4

" Search options
set ignorecase
set smartcase

" Windowing options
set splitright
set splitbelow

" Color / GUI
set t_Co=256
set termguicolors
colorscheme onehalfdark

let mapleader = ";"

""==============================""
""======== Key mappings ========""
""==============================""

inoremap jj <ESC>
inoremap jk <ESC>

nmap j gj
nmap k gk

" Disable search
nnoremap <silent><ESC> :nohlsearch<CR>

" Allow '%%' to insert current directory to buffer
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Keymaps for system clipboard
nmap Y "+y
vmap Y "+y
nmap <leader>p "+p

nmap <leader>bd :bdelete<CR>

""==============================""
""======= Autocommands =========""
""==============================""

autocmd BufWritePre * :%s/\s\+$//e

autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup='Visual', timeout=300}


execute 'luafile ' . stdpath('config') . '/nvim.lua'
