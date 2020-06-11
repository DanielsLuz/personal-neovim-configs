" INIT config
"Set vim config files path
let $MYVIMCFG = '$HOME/.config/nvim/config'
"Incremental search, jump as I type
set incsearch
syntax enable
"remap LEADER
let mapleader=","
"disable arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
"enabling the ctags
set tags=./tags;
set noswapfile
" Use ack instead of grep
set grepprg=ag\ --path-to-ignore\ ~/.ignore\ --nogroup\ --nocolor
" Wildignores for ctrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.cabal-sandbox,.tmp
set wildmode=longest:full,full

set path=.,src
set suffixesadd=.js,.vue

"""""""""""""""""""
set nocompatible
filetype off
filetype plugin indent on
set showmatch
"set tab to 2 spaces rather than 4
set tabstop=2
set shiftwidth=2
set expandtab
set nowrap
set scrolloff=10
set number
set notimeout
set ttimeout
set ttimeoutlen=10
set splitbelow
set splitright
" set the runtime path to include Vundle and initialize
set rtp+=~/.fzf
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" Global utils
Plugin 'radenling/vim-dispatch-neovim'
Plugin 'tpope/vim-dispatch'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" Linting
" Plugin 'neomake/neomake'
Plugin 'dense-analysis/ale'
" Searching
Plugin 'mileszs/ack.vim'
" Some colorschemes
" Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'drewtempelmeyer/palenight.vim'
" Git utils
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
" Navigation
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf.vim'
Plugin 'ludovicchabant/vim-gutentags'
" Better buffers
Plugin 'itchyny/lightline.vim'
Plugin 'taohexxx/lightline-buffer'
" Autocompletion
Plugin 'Shougo/deoplete.nvim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mattn/emmet-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-surround'
"Javascript plugins
" Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'posva/vim-vue'
Plugin 'pangloss/vim-javascript'
Plugin 'Valloric/MatchTagAlways'
"Rails plugins
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
call vundle#end()            " required
filetype plugin indent on    " required

"APPEARANCE SETTINGS
set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1
noremap <F7> :highlight Normal guibg=none<CR>
noremap <F8> :highlight Normal guibg=#292D3E<CR>
"CUSTOM MAPPINGS
nnoremap <leader>w :w<CR>
nnoremap <leader>q :wa<CR>
nnoremap <space> /

"remap exit insert mode
ino jj <esc>
cno jj <c-c>
tnoremap jj <C-\><C-n>
tnoremap <C-k> <UP>
tnoremap <C-j> <DOWN>

"Useful mappings
""go to next and previous buffer
nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Maps backspace to last buffer
nmap <BS> <C-^>

" Remaping K for search under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" QuickFix navigation
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

nnoremap <leader>% :MtaJumpToOtherTag<cr>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

"map BufOnly command
map <leader>bo :BufOnly<CR>

"Remove all trailing whitespace by pressing F3
nnoremap <F3> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

"map \s to rename variable
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

"Set pastetoggle, keeps indentation
set pastetoggle=<F2>
nmap <Leader>m :NERDTreeToggle<CR>
nmap <Leader>n :NERDTreeFind<CR>
noremap <F9> :cclose<cr>
noremap <F10> :copen 40<cr>

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

nnoremap <leader>y :let @+=expand("%") . ':' . line(".")<CR>
" After block yank and paste, move cursor to the end of operated text and don't override register
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

" Don't cancel visual select when shifting
xnoremap <  <gv
xnoremap > >gv
" Reselect last-pasted text
nnoremap gp `[v`]
" Keep the cursor in place while joining lines
nnoremap J mzJ`z
" [S]plit line (sister to [J]oin lines) S is covered by cc.
" nnoremap S mzi<CR><ESC>`z
" Source (reload configuration)
nnoremap <silent> <F5> :source $MYVIMRC<CR>
" Toggle search highlight
nnoremap <CR> :noh<CR>

"PLUGIN SETTINGS
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_vue_eslint_exe = $PWD .'/node_modules/.bin/eslint'
let g:deoplete#enable_at_startup = 1
" autocmd FileType vue syntax sync fromstart
" autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

"deoplete

" deoplete configuration
let g:deoplete#enable_refresh_always=0
let g:deoplete#enable_smart_case=1

let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'tags']
let deoplete#tag#cache_limit_size = 5000000

" snippet completion
inoremap <c-x><c-k> <c-x><c-k>
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"lightline
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden
"vim-airline configurations
set laststatus=2
set showtabline=2  " always show tabline
let g:lightline = {
      \ 'tabline': {
      \   'left': [ [ 'bufferinfo' ],
      \             [ 'separator' ],
      \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
      \   'right': [ [ 'close' ], ],
      \ },
      \ 'component_expand': {
      \   'buffercurrent': 'lightline#buffer#buffercurrent',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \ },
      \ 'component_type': {
      \   'buffercurrent': 'tabsel',
      \   'bufferbefore': 'raw',
      \   'bufferafter': 'raw',
      \ },
      \ 'component_function': {
      \   'bufferinfo': 'lightline#buffer#bufferinfo',
      \ },
      \ 'component': {
      \   'separator': '',
      \ },
      \ }
let g:lightline.colorscheme = 'palenight'

" Or in ~/.vim/vimrc:
" Run both javascript and vue linters for vue files.
let b:ale_linter_aliases = ['javascript', 'vue']
let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\}

"nerdtree configuration
"Toggle NERDTree
let g:NERDTreeWinSize=30

"fzf configuration
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>. :FZF -e<CR>
let $FZF_DEFAULT_COMMAND = 'ag --hidden -g ""'
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
"emmet plugin, html and css
let g:user_emmet_leader_key='<C-X>'

"vim-rails
nnoremap <leader>rf :.Rails<CR>
nnoremap <leader>rs :Rails<CR>

"quickfix settings
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

augroup vue_ft
  au!
  autocmd BufNewFile,BufRead *.vue   set filetype=vue
augroup END

"Neovim configs
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
set clipboard+=unnamedplus
let g:syntastic_ignore_files = ['\.java$']

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

function! MyFoldText()
    let nblines = v:foldend - v:foldstart + 1
    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let line = getline(v:foldstart)
    let comment = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    let expansionString = repeat(".", w - strwidth(nblines.comment.'"'))
    let txt = comment . expansionString . nblines
    return txt
endfunction
set foldtext=MyFoldText()
hi FOLDED guifg=white

nnoremap <silent> <C-C><C-K> :call OpenCSSRuleDocs()<CR>
function! OpenCSSRuleDocs()
  let CSSDocsURL = 'https://developer.mozilla.org/en-US/docs/Web/CSS'
  silent exec "!x-www-browser " . CSSDocsURL . "/" . expand("<cword>")
endfunction
