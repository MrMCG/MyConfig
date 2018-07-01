
"--------------------------------
" Enable / Disables
"--------------------------------

set showcmd " shos typed commands
set ruler " shows line + column nums
set incsearch " performs incremental search while typing
set showmode " shows current mode
set ignorecase " case insensitive search

set smartcase " enables case sensitive if includes upper-case
" set autoindent " enables indent | replaced by cindent?
set cindent " strict c indent rules
set hlsearch " highlighted search
set noerrorbells " disables beeping

set nofoldenable " disables folding
set expandtab " tab converted to spaces
set nocompatible " not compatible with vi
set number " show line numbers
set noswapfile " disables .swp file creation

set wildmenu " enables command line completion
set mouse= " disable vim mouse for copy/paste

"--------------------------------
" Set Values
"--------------------------------

set wrapmargin=0 " no word wrapping
set textwidth=0 " no word wrapping
set ts=4 " tab is 4 spaces
set sw=4 " auto indent is 4 spaces
set matchpairs+=<:> " add <> to matching pairs

set wildmode=longest,full " complete longest common + full match 
set wildignore+=*.o,*.s,*.S " ignore these files when searching

set tags=./.tags; " tell vim to look for .tags in parent
set completeopt= " only show menu for completion

" enable filetype detection + load indent files
filetype plugin indent on

"--------------------------------
" Mappings
"--------------------------------

" set F3 to open bufexplorer
map <F3> \bt 
" maps to run clang-format
map <C-K> :pyf /home/user/dev/formatting/clang-format.py<cr> " normal + visual mode
imap <C-K> <c-o>:pyf /home/user/dev/formatting/clang-format.py<cr> " insert mode
" F8 to auto fix ycm diag errors
map <F8> :YcmCompleter FixIt<CR>
" ctrl-s to write file
map <C-s> :w<CR>


"--------------------------------
" Commands / Alias
"--------------------------------

" use lower w when given W (with context)
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
" use lower q when given Q (with context)
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))

""command build execute 

"--------------------------------
" Plugin Settings
"--------------------------------

" begin Vundle stuff

set nocompatible              " be iMproved, required
filetype off                  " requiredo
set rtp+=~/.vim/bundle/Vundle.vim " find vundle

call vundle#begin()            " required

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'octol/vim-cpp-enhanced-highlight'

call vundle#end()            " required
filetype plugin indent on    " required
syntax on " enable syntax highlighting

" end vundle stuff

" cpp highlighting
let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_decl_highlight=1
let g:cpp_experimental_simple_template_highlight=1

" youCompleteMe
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<UP>', '<DOWN>']
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_auto_trigger = 0
set encoding=utf-8

" bufExplorer
let g:bufExplorerSortBy='name'       " Sort by the buffer's name.
let g:bufExplorerShowDirectories=0   " Do not show directories.


"--------------------------------
" Plugins Used
"--------------------------------

" C++ Highlighting: https://github.com/octol/vim-cpp-enhanced-highlight
" bufExplorer: https://github.com/jlanzarotta/bufexplorer
" flip: by Mark Lees
" AutoClose: https://github.com/Townk/vim-autoclose
" YoucompleteMe: https://valloric.github.io/YouCompleteMe/
" vundle: https://github.com/VundleVim/Vundle.vim 

