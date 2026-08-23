let g:loaded_python3_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_matchit = 1
let g:loaded_2html_plugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin = 1

let s:plug_path = expand(has('win32') ? '~/vimfiles/autoload/plug.vim' : '~/.vim/autoload/plug.vim')
if empty(glob(s:plug_path))
  echo "Installing vim-plug..."
  let s:plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  if has('win32')
    silent execute '!powershell -Command "iwr -useb ' . s:plug_url . ' | ni ' . s:plug_path . ' -Force"'
  else
    silent execute '!curl -fLo ' . s:plug_path . ' --create-dirs ' . s:plug_url
  endif
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set ai si hls ic scs is cb+=unnamedplus cot=menu,menuone,noselect ts=2 sw=2 sts=2 noet cul nu
set completeopt=menuone,noinsert,noselect
set clipboard=unnamed,unnamedplus
set shortmess+=cFsIa
set mouse=
set autoindent cindent
set encoding=utf-8
set hidden
set updatetime=100
"set signcolumn=yes
filetype plugin indent on
set wildmenu
set wildoptions=pum,fuzzy
set wildmode=longest:full,full
set wildignore+=*.o,*.obj,*.bin,*.exe,*.so,*.a
set encoding=utf-8
set nobackup nowritebackup noswapfile
set visualbell noerrorbells belloff=all
set t_vb=
set foldmethod=marker
" set aw 
let mapleader = " "
colorscheme default


if isdirectory(expand('~/cp'))
  cd ~/cp
endif

nno <C-h> <C-w>h
nno <C-j> <C-w>j
nno <C-k> <C-w>k
nno <C-l> <C-w>l
autocmd FileType netrw nmap <buffer> <C-h> <C-w>h
autocmd FileType netrw nmap <buffer> <C-j> <C-w>j
autocmd FileType netrw nmap <buffer> <C-k> <C-w>k
autocmd FileType netrw nmap <buffer> <C-l> <C-w>l
autocmd FileType cpp nno <buffer> <F9> :w<CR>:bo terminal ++close sh -c "make %< && ./%<; read"<CR>
autocmd FileType cpp nno <buffer> <F10> :bo terminal ++close sh -c "./%<; read"<CR>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 30
let g:netrw_keepdir = 0
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_list_hide = '^\..*,^\.\./$,\.o$,\.out$'


" --- Relative Line Numbers Toggle ---
aug numbertoggle
    au!
    au BufEnter,FocusGained,InsertLeave * set rnu
    au BufLeave,FocusLost,InsertEnter * set nornu
aug END

call plug#begin()

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-commentary'
" Plug 'rafamadriz/friendly-snippets'
Plug 'bfrg/vim-cpp-modern'
Plug 'girishji/vimsuggest'
" Plug 'luochen1990/rainbow'
Plug 'mao-yining/undotree.vim'
Plug 'lambdalisue/vim-fern'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

call plug#end()

let g:rainbow_active = 1
nno <silent> <Esc> :noh<CR><Esc>
nno <silent> <Leader>bp :bprevious<CR>
nno <silent> <Leader>bn :bnext<CR>
nno <silent> <Leader>u :UndotreeToggle<CR>
nno <silent> <Leader>bd :bdelete<CR>

" ----------------
" CoC
" ----------------

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ mode() ==# 'c' ? "\<Tab>" :
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" set autochdir

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nno <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call execute('!' . &keywordprg . " " . expand('<cword>'))
  endif
endfunction
let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-tsserver', 'coc-clangd']
autocmd User CocCmdlineEnter grep -q
autocmd User CocCmdlineLeave grep -q

" Enable CoC semantic highlighting automatically on buffer attach
let g:coc_default_semantic_highlight_groups = 1

augroup CocSemanticTokens
  autocmd!
  autocmd User CocNvimInit hi default link CocSemFunction Function
  autocmd User CocNvimInit hi default link CocSemMethod Function
  autocmd User CocNvimInit hi default link CocSemVariable Identifier
  autocmd User CocNvimInit hi default link CocSemParameter Identifier
  autocmd User CocNvimInit hi default link CocSemClass Type
  autocmd User CocNvimInit hi default link CocSemEnumMember Constant
augroup END

hi Pmenu guibg=#e1e1e1 guifg=#000000 gui=NONE
hi PmenuSel guibg=#2b5b84 guifg=#ffffff gui=bold


hi CocErrorHighlight   ctermbg=NONE guibg=NONE cterm=undercurl gui=undercurl guisp=#ff0000
hi CocWarningHighlight ctermbg=NONE guibg=NONE cterm=undercurl gui=undercurl guisp=#ffb000
hi CocInfoHighlight    ctermbg=NONE guibg=NONE cterm=undercurl gui=underline guisp=#00aaff
hi CocHintHighlight    ctermbg=NONE guibg=NONE cterm=undercurl gui=undercurl guisp=#00ffff
hi CocUnusedHighlight  ctermbg=NONE guibg=NONE cterm=italic gui=italic guifg=#323232

let s:vim_suggest = {}
let s:vim_suggest.cmd = {
    \ 'enable': v:true,
    \ 'pum': v:true,
    \ 'exclude': [],
    \ 'onspace': ['b\%[uffer]','colo\%[rscheme]'],
    \ 'alwayson': v:true,
    \ 'popupattrs': {},
    \ 'wildignore': v:true,
    \ 'addons': v:true,
    \ 'trigger': 't',
    \ 'reverse': v:false,
    \ 'prefixlen': 1,
\ }
let s:vim_suggest.search = {
    \ 'enable': v:true,
    \ 'pum': v:true,
    \ 'fuzzy': v:false,
    \ 'alwayson': v:true,
    \ 'popupattrs': {
    \   'maxheight': 12
    \ },
    \ 'range': 100,
    \ 'timeout': 200,
    \ 'async': v:true,
    \ 'async_timeout': 3000,
    \ 'async_minlines': 1000,
    \ 'highlight': v:true,
    \ 'trigger': 't',
    \ 'prefixlen': 1,
\ }
let s:vim_suggest.cmd.exclude = [
    \ '^\s*\d*\s*b\%[uffer]!\?\s\+',
    \ '^\s*\d*\s*sb\%[uffer]!\?\s\+'
    \ ]
autocmd VimEnter * call g:VimSuggestSetOptions(s:vim_suggest)
hi VimSuggestMatch ctermfg=DarkBlue guifg=#1F5582 guibg=#E0E0E0 cterm=bold gui=bold
hi VimSuggestMatchSel ctermfg=White guifg=#FFFFFF guibg=#2A5D8A cterm=bold gui=bold
hi VimSuggestMute ctermfg=Gray guifg=#7D848A guibg=#E0E0E0
let s:term_buf = 0

tnoremap <Leader>p <C-w>"+
tnoremap <Esc> <C-\><C-n>

let g:fern#default_hidden = 1
nno <silent> - :Fern . -drawer -toggle -reveal=%<CR>

augroup FernCustom
  autocmd!
  " Close drawer automatically when opening a file
  autocmd FileType fern nmap <buffer> <CR> <Plug>(fern-action-open:or-enter)<Plug>(fern-action-drawer:close)
augroup END

" Gvim
if has("gui_running")
	autocmd GUIEnter * set t_vb=
    set guioptions-=m  " Remove menu bar
    set guioptions-=T  " Remove toolbar
    set guioptions-=r  " Remove right scrollbar
    set guioptions-=L  " Remove left scrollbar
    set guioptions+=k  " Prevent window resize
    if has("gui_gtk2") || has("gui_gtk3")
        set gfn=Iosevka\ Fixed\ Extended\ 11,monospace\ 11
    elseif has("gui_win32")
        set gfn=Consolas:h11
    endif
endif
" Higlights
hi SignColumn guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi! NonText ctermbg=NONE guibg=NONE
