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

set ai si hls ic scs is cb+=unnamedplus cot=menu,menuone,noselect ts=4 sw=4 sts=4 noet cul nu
set completeopt=menuone,noinsert,noselect
set clipboard=unnamed,unnamedplus
set shortmess+=c

let mapleader = " "

if isdirectory(expand('~/cp'))
  cd ~/cp
endif

syn on
filetype plugin indent on
set wildmenu
set wildoptions=pum,fuzzy
set wildmode=longest:full,full
set wildignore+=*.o,*.obj,*.bin,*.exe,*.so,*.a
set encoding=utf-8
set nobackup nowritebackup

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

if has("gui_running")
    set guioptions-=m  " Remove menu bar
    set guioptions-=T  " Remove toolbar
    set guioptions-=r  " Remove right scrollbar
    set guioptions-=L  " Remove left scrollbar
    set guioptions+=k  " Prevent window resize
    if has("gui_gtk2") || has("gui_gtk3")
        set gfn=JetBrains\ Mono\ NL\ 11,monospace\ 11
    elseif has("gui_win32")
        set gfn=Consolas:h11
    endif
endif

" --- Relative Line Numbers Toggle ---
aug numbertoggle
    au!
    au BufEnter,FocusGained,InsertLeave * set rnu
    au BufLeave,FocusLost,InsertEnter * set nornu
aug END

call plug#begin()

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-commentary'
Plug 'rafamadriz/friendly-snippets'
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

set encoding=utf-8
set hidden
set updatetime=100
"set signcolumn=yes
highlight SignColumn guibg=NONE ctermbg=NONE

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

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call execute('!' . &keywordprg . " " . expand('<cword>'))
  endif
endfunction
let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-tsserver', 'coc-clangd', 'coc-snippets']
autocmd User CocCmdlineEnter grep -q
autocmd User CocCmdlineLeave grep -q


highlight CocErrorHighlight   gui=undercurl guisp=#ff5555
highlight CocWarningHighlight gui=undercurl guisp=#ffb86c
highlight CocInfoHighlight    gui=undercurl guisp=#8be9fd
highlight CocHintHighlight   gui=undercurl guisp=#50fa7b

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_stack_fold = 1
let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

" Enable CoC semantic highlighting automatically on buffer attach
let g:coc_default_semantic_highlight_groups = 1

augroup CocSemanticTokens
  autocmd!
  autocmd User CocNvimInit highlight default link CocSemFunction Function
  autocmd User CocNvimInit highlight default link CocSemMethod Function
  autocmd User CocNvimInit highlight default link CocSemVariable Identifier
  autocmd User CocNvimInit highlight default link CocSemParameter Identifier
  autocmd User CocNvimInit highlight default link CocSemClass Type
  autocmd User CocNvimInit highlight default link CocSemEnumMember Constant
augroup END

highlight Pmenu guibg=#e1e1e1 guifg=#000000 gui=NONE
highlight PmenuSel guibg=#2b5b84 guifg=#ffffff gui=bold
set visualbell noerrorbells
set t_vb=
set belloff=all

if has('gui_running')
  autocmd GUIEnter * set t_vb=
endif

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
highlight VimSuggestMatch ctermfg=DarkBlue guifg=#1F5582 guibg=#E0E0E0 cterm=bold gui=bold
highlight VimSuggestMatchSel ctermfg=White guifg=#FFFFFF guibg=#2A5D8A cterm=bold gui=bold
highlight VimSuggestMute ctermfg=Gray guifg=#7D848A guibg=#E0E0E0
let s:term_buf = 0

function! ToggleTerminal()
  if bufexists(s:term_buf)
    let l:job = term_getjob(s:term_buf)
    let l:is_alive = l:job != v:null && job_status(l:job) ==# 'run'
  else
    let l:is_alive = 0
  endif

  if !l:is_alive
    if bufexists(s:term_buf)
      execute 'bwipeout! ' . s:term_buf
    endif
    botright 15new
    let s:term_buf = bufnr('%')
    call term_start(&shell, {'curwin': 1})
    startinsert
  " 2. If split is currently visible, hide it
  elseif bufwinnr(s:term_buf) != -1
    execute bufwinnr(s:term_buf) . 'wincmd c'
  " 3. If split is hidden, reopen it
  else
    execute 'botright 15split +buffer' . s:term_buf
    startinsert
  endif
endfunction
nno <silent> <Leader>t :call ToggleTerminal()<CR>
tnoremap <Leader>p <C-w>"+
tnoremap <silent> <Leader>t <C-\><C-n>:call ToggleTerminal()<CR>
tnoremap <Esc> <C-\><C-n>

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:fern#default_hidden = 1
nno <silent> - :Fern . -drawer -toggle -reveal=%<CR>
augroup FernCustom
  autocmd!
  " Close drawer automatically when opening a file
  autocmd FileType fern nmap <buffer> <CR> <Plug>(fern-action-open:or-enter)<Plug>(fern-action-drawer:close)
augroup END
