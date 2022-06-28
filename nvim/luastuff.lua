syntax on
set number
set relativenumber
set autoindent
set noexpandtab
set ignorecase
set smartcase
set nohlsearch
set incsearch
set showmatch
set hidden
set scrolloff=8
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set signcolumn=yes
set cursorline
set autochdir

filetype plugin indent on
filetype indent on

let mapleader = " "
set rtp+=/usr/local/opt/fzf

" removes any highlighting
nnoremap <silent> <Leader>l :nohl<CR>

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'dylanaraps/wal.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Nice line under f and t for quick finding
Plug 'unblevable/quick-scope'
Plug 'itchyny/lightline.vim'
Plug 'vimwiki/vimwiki'
Plug 'tmsvg/pear-tree'
Plug 'airblade/vim-gitgutter'
Plug 'psliwka/vim-smoothie'
Plug 'Yggdroot/indentLine'
" To toggle hartime run :HardTimeOn/Off
Plug 'takac/vim-hardtime'
Plug 'christoomey/vim-tmux-navigator' 
" gc to comment out multiple lines at once in visual mode
Plug 'tpope/vim-commentary'
" plugin for saving vim sessions (mainly for tmux ressurect saving)
Plug 'tpope/vim-obsession'

" native lsp babyyyy
Plug 'neovim/nvim-lspconfig'


call plug#end()

colorscheme gruvbox
"colorscheme wal
"set bg=dark
highlight Normal ctermbg=NONE guibg=none

nnoremap <silent> <Leader>r :Rg<CR>
nnoremap <silent> <Leader>ff :GFiles<CR>

source $HOME/.config/nvim/coc.vim

"zt zb zz is cursor at top bottom and center respectively


" quickscope highlight only when pressing f and t 
let g:qs_highlight_on_keys = ['f','F','t','T']
" quickscope change colors
highlight QuickScopePrimary guifg='#17ebd6' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#ec80ff' gui=underline ctermfg=81 cterm=underline


"lightline changes colors
let g:lightline = {'colorscheme': 'wal'}

"vimwiki markdown change 
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"vim rooter set rooter

let g:smoothie_update_interval = 10
let g:smoothie_speed_constant_factor = 20
let g:smoothie_speed_linear_factor = 20

" setting update time to see if coc autocompletion is faster
set updatetime=100

" Setting tabs to lines for easier reading
set listchars=tab:\|\ 
set list 
" indentLine config, dont know if i need to delete above
let g:indentLine_char = '|'


" Remapping local and global marks
nnoremap mn mN
nnoremap 'n 'N
nnoremap me mE
nnoremap 'e 'E
nnoremap mi mI
nnoremap 'i 'I

" Command and Conquer jump error remaps
try
    nnoremap <silent> <Leader>n :call CocAction('diagnosticNext')<cr>
    nnoremap <silent> <Leader>e :call CocAction('diagnosticPrevious')<cr>
endtry
