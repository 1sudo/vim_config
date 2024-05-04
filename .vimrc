" Note: You will get a conflict warning about installing gvim if vim is
" already installed. Install it anyway.
" sudo pacman -S ttf-jetbrains-mono-nerd rust-analyzer gvim alacritty

filetype plugin indent on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/limelight.vim'
Plugin 'dracula/vim.git'
Plugin 'yegappan/lsp'
call vundle#end()

syntax on
colorscheme dracula

" Required to make lightline show up
set laststatus=2
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set relativenumber
set tabpagemax=50
set clipboard=unnamed

let mapleader=" "

" Display buffers and LSP diag
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Leader>d :LspDiag show<CR>
map <C-t> :NERDTreeToggle<CR>

" Disable arrow keys
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" Go to beginning of line that isn't whitespace
map bl ^
" Go to end of line
map el $
" Create new tab
map nt :tabnew<CR>
" Fuzzy finder hotkey
map ; :Files<CR>
" Copy to OS clipboard
map <F1> "+y

" Function for transparent vim background
let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_transparent = 0
    endif
endfunction

" Automatically toggle transparency when Vim starts
autocmd VimEnter * call Toggle_transparent()

let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

" Install rust-analyzer (separate from the rustup install) and add the path
let lspServers = [#{
	\	  name: 'rustlang',
	\	  filetype: ['rust'],
	\	  path: '/home/zac/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer',
	\	  args: [],
	\	  syncInit: v:true
	\ }]

" Define a group for all LSP-related autocmds
augroup lsp_setup
  autocmd!
  autocmd User LspSetup call LspAddServer(lspServers)
augroup END
