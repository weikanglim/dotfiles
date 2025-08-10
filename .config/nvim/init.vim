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

" Windowing
nmap <C-l> <C-w>l
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h

" Disable search
nnoremap <silent><ESC> :nohlsearch<CR>

" Allow '%%' to insert current directory to buffer
cnoremap %% <C-R>=expand('%:h').'/'<CR>

" Keymaps for system clipboard
nmap Y "+y
vmap Y "+y
nmap <leader>p "+p
nmap <leader>P "+P

" Buffers
nmap <leader>bd :bdelete<CR>
nmap <leader>bb :FzfLua buffers<CR>

" Finding stuff
nmap <leader>ff :FzfLua files<CR>
nmap <leader>fg :FzfLua grep<Space>
nmap <leader>fh :FzfLua helptags<CR>
nmap <leader>fR :FzfLua resume<CR>

" Git
nmap <leader>gl :FzfLua git_commits<CR>
nmap <leader>gb :FzfLua git_bcommits<CR>

" Code actions
nmap <leader>ca :FzfLua lsp_code_actions<CR>
inoremap <C-space> <C-x><C-o>

""==============================""
""======= Autocommands =========""
""==============================""

autocmd BufWritePre * :%s/\s\+$//e

autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup='Visual', timeout=300}

execute 'luafile ' . stdpath('config') . '/nvim.lua'

