"     __   _(_)_ __ ___  _ __ ___
"      \ \ / / | '_ ` _ \| '__/ __|
"       \ V /| | | | | | | | | (__
"      (_)_/ |_|_| |_| |_|_|  \___|
"

" Who cares about vi?
set nocompatible


if system('uname -s') == "Darwin\n"
    "OSX
    let g:os="osx"
	set clipboard=unnamed,unnamedplus
else
    "Linux
    let g:os="linux"
endif
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                 GUI
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions+=c
    set guifont=Consolas\ for\ Powerline\ 15

    set t_Co=256
endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               General
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


let mapleader = ","
set number
set relativenumber
set showcmd
set autoread
set modeline
" set autochdir

set sessionoptions+=globals

set title titlestring=%(%{expand(\"%:~:p:t\")}%)%(\ %M%)

set mouse=a
" set completeopt=menu,menuone,preview,noselect,noinsert
set nohidden
set noswapfile
set nobackup
set nowritebackup

set wildignore+=node_modules,.build,__pycache__,venv,.git,.hg,.svn,*.o,*.aux,*.png,*.jpg,*.pdf
set nofoldenable
syntax on

" Make backspace work like other editors.
set backspace=indent,eol,start

" Disable Ex mode.
nnoremap Q <nop>

" Avoid the escape key.
inoremap jj <Esc>

" Clear highlighting.
nnoremap <silent> <Esc> :noh<CR><Esc>

" Centered search results.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default.
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" No whitespace in vimdiff.
set diffopt+=iwhite

" Make diffing better: https://vimways.org/2018/the-power-of-diff/.
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

let g:tex_flavor="latex"

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               Plugins
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
filetype off

call plug#begin('~/.vim/plugged')

" " Interface.
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'machakann/vim-highlightedyank'

" Text.
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'lyokha/vim-xkbswitch'

Plug 'arakashic/chromatica.nvim', {'for': ['c', 'cpp'], 'do': ':UpdateRemotePlugins'}
" Plug 'ciaranm/detectindent'
Plug 'tpope/vim-markdown', { 'for': ['markdown'] }
Plug 'godlygeek/tabular', { 'for': ['tex', 'markdown'] }
"Plug 'lyokha/vim-xkbswitch'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'dyng/ctrlsf.vim'
Plug 'wsdjeg/FlyGrep.vim'
Plug 'justinmk/vim-sneak'

" Integrations.
"Plug 'vim-scripts/dbext.vim'
Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'
Plug 'tpope/vim-fugitive'
Plug 'rizzatti/dash.vim'
Plug 'airblade/vim-rooter'
" Plug 'metakirby5/codi.vim'
" Plug 'w0rp/ale'
Plug 'Shougo/echodoc.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'will133/vim-dirdiff'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jackguo380/vim-lsp-cxx-highlight'

" if has('nvim')
"     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"     Plug 'Shougo/deoplete.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
" endif

" Languages.
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent' " Optional
Plug 'dbgx/lldb.nvim'
Plug 'lervag/vimtex'
Plug 'cespare/vim-toml'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'peitalin/vim-jsx-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'maksimr/vim-yate'
Plug 'hynek/vim-python-pep8-indent'
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': ['jinja', 'jinja2'] }
Plug 'mustache/vim-mustache-handlebars'
" Plug 'carlitux/deoplete-ternjs'
Plug 'pearofducks/ansible-vim'

call plug#end()

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"             Indentation
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab

" Auto indent pasted text.
" nnoremap p p=`]
" nnoremap P P=`]

filetype plugin indent on

" Display tabs and trailing spaces visually.
set list listchars=tab:\ \ ,trail:·

set nowrap
set linebreak

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"              Scrolling
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set scrolloff=8
set sidescrolloff=5
set sidescroll=1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               Search
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set incsearch
set hlsearch
set ignorecase
set smartcase

nnoremap <C-[> <C-o>
nnoremap <C-]> <C-i>

if has('nvim')
    set inccommand=split
endif


function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
nmap <leader>j :call GotoJump()<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"              Spelling

set nospell
set spellfile=~/.vim/spell/shit.utf-8.add
set spelllang=en,ru


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"             Session
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set undofile
set undodir=~/.config/nvim/undodir

augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"             Tab
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Useful mappings for managing tabs
map <A-t> :tabnew<cr>
map <A-w> :tabclose<cr>
map <A-l> :tabnext<cr>
map <A-h> :tabprevious<cr>
map <A-RIGHT> :tabnext<cr>
map <A-LEFT> :tabprevious<cr>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"             Appearance
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set notermguicolors
set background=dark
colorscheme gruvbox
let g:gruvbox_italic=1
let &colorcolumn="80,100"

" Lines.
set cursorline
set synmaxcol=900

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               Splits
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" Sane splits.
set splitbelow
set splitright

" Easy movement.
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-DOWN> <C-w>j
nnoremap <C-UP> <C-w>k
nnoremap <C-RIGHT> <C-w>l
nnoremap <C-LEFT> <C-w>h

if has('nvim')
    " Some terminal settings.
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd TermOpen * setlocal nonumber norelativenumber

    tnoremap <ESC> <C-\><C-n>
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-DOWN> <C-\><C-n><C-w>j
    tnoremap <C-UP> <C-\><C-n><C-w>k
    tnoremap <C-RIGHT> <C-\><C-n><C-w>l
    tnoremap <C-LEFT> <C-\><C-n><C-w>h
endif

" Resize the split panes to become equal when the host window is resized.
autocmd VimResized * wincmd =

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"         Move up/down lines
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               chromatica
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:chromatica#libclang_path='/usr/local/Cellar/llvm/8.0.0_1/lib'


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               Semshi 
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

autocmd FileType python nmap <silent> <leader>sr :Semshi rename<CR>
autocmd FileType python nmap <silent> <Tab> :Semshi goto name next<CR>
autocmd FileType python nmap <silent> <S-Tab> :Semshi goto name prev<CR>
autocmd FileType python nmap <silent> <leader>sc :Semshi goto class next<CR>
autocmd FileType python nmap <silent> <leader>sC :Semshi goto class prev<CR>
autocmd FileType python nmap <silent> <leader>sf :Semshi goto function next<CR>
autocmd FileType python nmap <silent> <leader>sF :Semshi goto function prev<CR>
autocmd FileType python nmap <silent> <leader>se :Semshi error<CR>
autocmd FileType python nmap <silent> <leader>sge :Semshi goto error<CR>


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                NERDTree
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:NERDTrimTrailingWhitespace = 1
let g:NERDSpaceDelims = 1
let g:NERDTreeHijackNetrw = 1
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                NERDTree
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

let g:NERDTreeIndicatorMapCustom = {
  \ 'Modified'  : '±',
  \ 'Untracked' : '✪',
  \ 'Renamed'   : '➲',
  \ 'Unmerged'  : '≈',
  \ 'Deleted'   : '×',
  \ }

nnoremap <silent> <leader>x :NERDTreeToggle %<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                FlyGrep
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:sneak#s_next = 1
let g:spacevim_debug_level = 0


""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
""               Vim-Markdown
""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:markdown_fenced_languages = ['sh', 'php=php', 'css', 'js=javascript']
let g:vim_markdown_fenced_languages = ['sh', 'php=php', 'css', 'js=javascript']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_math = 1

""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
""               vim-xkbswitch 
""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:XkbSwitchEnabled = 1
let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.dylib'
let g:XkbSwitchIMappings = ['ru']

""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
""               Coc
""~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nmap <leader>s :execute 'CocSearch -w '.expand('<cword>')<CR>
" nmap <leader>s ::CocSearch -w
nmap f <Plug>(coc-smartf-forward)
nmap F <Plug>(coc-smartf-backward)
nmap ; <Plug>(coc-smartf-repeat)
nmap , <Plug>(coc-smartf-repeat-opposite)

augroup Smartf
	autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
	autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
augroup end<Plug>CocRefresh

let g:coc_filetypes = []

autocmd CursorHold * silent call CocActionAsync('highlight')

call coc#config('diagnostic', {
\ 'errorSign': '✖',
\ 'warningSign': '⚠',
\ 'infoSign': 'ℹ'
\})

"" C/C++
call coc#add_extension('coc-ccls')
let g:coc_filetypes += ['c', 'cpp']
if g:os == "osx" 
    call coc#config('languageserver.ccls.initializationOptions.clang',
                \ {
                \ "resourceDir": "/Library/Developer/CommandLineTools/usr/lib/clang/10.0.1",
                \ "extraArgs": [
                \   "-Wno-unused-variable",
                \   "-isystem",
                \   "/Library/Developer/CommandLineTools/usr/include/c++/v1/",
                \  "-I", "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/"
                \ ]
                \ })
endif
"" Java
call coc#add_extension('coc-java')
let g:coc_filetypes += ['java']
autocmd FileType java let b:coc_root_patterns = ['pom.xml', '.git', '.env', 'package.json']

"" Go
call coc#add_extension('coc-go')
let g:coc_filetypes += ['go']

augroup vimrc-go
augroup END

"" Rust
call coc#add_extension('coc-rls')
let g:coc_filetypes += ['rust']
call coc#config('rust', { 'clippy_preference': 'on' })
autocmd FileType rust let b:coc_root_patterns = ['Cargo.toml', '.git', '.env']

let g:rust_recommended_style = 0

augroup vimrc-rust
  autocmd FileType rust setlocal matchpairs-=<:>
augroup END

"" Python
call coc#add_extension('coc-python')
let g:coc_filetypes += ['python']

augroup vimrc-language-python
  autocmd!
augroup END
autocmd FileType python let b:coc_root_patterns = ['manage.py', 'venv', 'requirements.txt', '.git', '.env']
let g:python_highlight_all = 1

"" PHP
call coc#add_extension('coc-phpls')
let g:coc_filetypes += ['php']
autocmd FileType php let b:coc_root_patterns = ['.git', '.env', 'composer.json']

""TypeScript
call coc#add_extension('coc-tsserver',  'coc-tslint-plugin')
let g:coc_filetypes += ['typescript.jsx', 'typescript']
call coc#config('tslint-plugin', {
			\ 'filetypes': ['typescript', 'typescript.tsx'],
			\ 'autoFixOnSave': v:false,
			\ })

""JS
call coc#add_extension('coc-eslint')
let g:coc_filetypes += ['javascript', 'javascript.jsx']
autocmd FileType typescript,tsx,jsx,js,ts let b:coc_root_patterns = ['.git', '.env', 'package.json']
call coc#config('eslint', {
\ 'filetypes': ['javascript', 'javascript.jsx'],
\ 'autoFixOnSave': v:false,
\ })

" call coc#config('prettier', {
" \ 'singleQuote': v:true,
" \ 'trailingComma': 'all',
" \ 'jsxBracketSameLine': v:true,
" \ 'eslintIntegration': v:true,
" \ })


function IsCocEnabled()
  return index(g:coc_filetypes, &filetype) >= 0
endfunction


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at surrent position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)
" nmap <silent> <leader>e <Plug>(coc-diagnostic)

" Remap keys for gotos
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>n <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               airline
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set laststatus=2
set showtabline=2
set noshowmode

let g:airline_section_c="%{expand('%:~:.:s|/src/|/s/|:s|^\\~/projects/|λ/|')}"
let g:airline#extensions#tabline#fnamemod=':~:s|^\~/projects/\(.\{-}\)/\(.\{-}\)\(/.*\)\=$|[\1] \2|'

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_splits=0
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#show_tab_type=0
let g:airline#extensions#tabline#fnamecollapse=0
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" let g:airline_extensions= ['branch', 'coc', 'denite', 'vimtex', 'undotree', 'fugitiveline', 'hunks']
let g:airline_powerline_fonts=1
" au User AirlineAfterInit let g:airline_section_x = airline#section#create(["readonly", "%{get(b:, 'coc_git_blame', ' ')}"])
" let g:airline_section_b = '%{get(g:,"coc_git_status", "")}%{get(b:, "coc_git_status", "")}'
"let g:airline_section_b = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}%{coc#status()}"
" let g:airline_section_b = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{coc#status()}"
let g:airline_section_b = "%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')} %{coc#status()}"

if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif

let g:airline_mode_map = {
\   '__': '-',
\   'n' : 'N',
\   'i' : 'I',
\   'ic' : 'IC',
\   'R' : 'R',
\   'c' : 'C',
\   'v' : 'V',
\   'V' : 'V',
\   '': 'V',
\   's' : 'S',
\   'S' : 'S',
\   '': 'S',
\   't' : 'T',
\}

" "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" "                  ALE
" "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" 
" let g:ale_linters={
" \   'rust': ['cargo'],
" \	'go': ['golangci-lint', 'gopls'],
" \   'python': [],
" \   'javascript': ['eslint', 'flow'],
" \   'typescript': ['tslint', 'tsserver'],
" \   'php': ['phan', 'phpmd', 'php', 'psalm'],
" \   'reason': ['ols'],
" \   'c': [],
" \   'cpp': [],
" \}
" "\   'python': ['mypy', 'pylint', 'flake8'],
" 
" let g:ale_c_ccls_init_options = {
" 	\ 'cache': {'directory': '/tmp/ccls'},
" 	\ 'clang': {
" 	\   "extraArgs": [
" 	\       "-I",
" 	\       "/usr/local/Cellar/llvm/8.0.0_1/include/"
" 	\	]
" 	\ } 
" 	\ }
" 
" 
" call ale#linter#Define('php', {
" \   'name': 'psalm',
" \   'lsp': 'stdio',
" \   'executable': {b -> ale#node#FindExecutable(b, 'psalm_langserver', [
" \       'vendor/bin/psalm-language-server',
" \   ])},
" \   'command': '%e',
" \   'project_root': getcwd(),
" \})
" 
" let g:context_derived_golangci_yml = getcwd() + "/.golangci.yml"
" if filereadable(g:context_derived_golangci_yml)
"     let g:ale_go_golangci_lint_options = "--enable-all --fast -c " . g:context_derived_golangci_yml
" else
"     let g:ale_go_golangci_lint_options = "--enable-all --fast"
" endif
" 
" call ale#linter#Define('go', {
"    \ 'name': 'revive',
"    \ 'output_stream': 'both',
"    \ 'executable': 'revive',
"    \ 'read_buffer': 0,
"    \ 'command': 'revive %t',
"    \ 'callback': 'ale#handlers#unix#HandleAsWarning',
"    \ })
" 
" let g:ale_fixers={
" \   '*': ['trim_whitespace', 'remove_trailing_lines'],
" \   'go': ['goimports'],
" \   'rust': ['rustfmt'],
" \   'python': [],
" \   'javascript': ['eslint'],
" \   'typescript': ['tslint'],
" \   'reason': ['refmt'],
" \}
" 
" let g:ale_linter_aliases = {'typescript': ['typescript', 'tsx', 'typescript.tsx']}
" 
" nmap <silent> <leader>an :ALENext<cr>
" nmap <silent> <leader>ap :ALEPrevious<cr>
" let g:ale_c_parse_makefile=1
" let g:ale_rust_cargo_use_clippy=executable('cargo-clippy')
" let g:ale_rust_cargo_check_all_targets=1
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_fix_on_save=0
" let g:ale_virtualtext_cursor=1
" let g:ale_virtualtext_prefix='‣ '
" let g:ale_sign_error='✖'
" let g:ale_sign_warning='⚠'
" let g:ale_sign_info='ℹ'
" 
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
" highlight clear ALEInfoSign
" 
" highlight link ALEVirtualTextError GruvboxRed
" highlight link ALEVirtualTextWarning GruvboxYellow
" highlight link ALEVirtualTextInfo GruvboxGray
" highlight link ALEVirtualTextStyleError GruvboxRed
" highlight link ALEVirtualTextStyleWarning GruvboxYellow
" 
" nmap <A-d>      <Plug>(ale_detail)
" nmap <A-f>      <Plug>(ale_fix)

function! s:check_battery()
    if g:os == "osx"
        call system('pmset -g batt | grep "Battery Power"')
    else
        call system('upower -d | grep -E "on-battery:\s+yes"')
    endif
    return v:shell_error == 0
endfunction

" Disable checking on text changed when use a battery.
let s:restricted=-1

function! s:powersafe_mode(timer)
    let on_battery = s:check_battery()
    if on_battery != s:restricted
        let s:restricted=on_battery

		if s:restricted == 1
			setl updatetime=4000
			" execute ":Semshi disable"
		else
			setl updatetime=400
			" execute ":Semshi enable"
		endif

		call coc#config('git', {
					\ 'xaddGBlameToVirtualText': s:restricted ? v:false: v:true,
					\ 'addGBlameToBufferVar': s:restricted ? v:false: v:true,
					\ 'enableGutters': s:restricted ? v:false: v:true
					\})
    endif
endfunction

call timer_start(5 * 1000, function('s:powersafe_mode'), {'repeat': -1})
call timer_start(1, function('s:powersafe_mode'), {'repeat': 0})

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                deoplete
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources#ternjs#types = 1
" 
" autocmd CompleteDone * silent! pclose!
" 
" function g:Multiple_cursors_before()
"     call deoplete#custom#buffer_option('auto_complete', v:false)
" endfunction
" function g:Multiple_cursors_after()
"     call deoplete#custom#buffer_option('auto_complete', v:true)
" endfunction

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                echodoc
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:echodoc#enable_at_startup = 1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               javascript
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:javascript_plugin_jsdoc=1
let g:javascript_plugin_flow=1

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"               xkbswitch
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:XkbSwitchEnabled=1
let g:XkbSwitchIMappings=['ru']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                dbext
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:dbext_default_window_use_horiz=0
let g:dbext_default_window_width=60
let g:dbext_default_window_increment=50

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                CtrlP
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let g:ctrlp_user_command=['.git', 'cd %s && git ls-files . -co --exclude-standard', 'cd %s && fd']
let g:ctrlp_root_markers=['.ccls', 'venv', 'Makefile', 'manage.py', '.root', '.git', 'package.json', 'go.mod', 'Cargo.toml']
" let g:ctrlp_working_path_mode='rc'
let g:ctrlp_match_func={'match': 'pymatcher#PyMatch'}

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                CtrlSF
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:ctrlsf_winsize = '35%'
let g:ctrlsf_default_view_mode = 'compact'
" let g:ctrlsf_default_root = 'project'

nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                FlyGrep
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" nnoremap <leader>s :FlyGrep<CR>
" vnoremap <leader>s :FlyGrep<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                Rust
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:rust_clip_command = 'pbcopy'

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                Rooter
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:rooter_silent_chdir=0
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns=['.git/', '.gradle/', '.root', '.git/', '.svn/', 'go.mod', 'package.json', 'Cargo.toml', 'requirements.txt', 'composer.json', '.vim/' , '.env']

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                Colors
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

highlight! link CocErrorSign GruvboxRed
highlight! link CocWarningSign GruvboxYellow
highlight! link CocInfoSign GruvboxGray
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"             File specific
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"TODO: what about using groups?
" highlight default BadWhitespace ctermbg=red guibg=red
" autocmd BufRead,BufNewFile *.py,*.c,*.h match BadWhitespace /\s\+$/
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType jinja,tex,html,markdown setlocal wrap spell cc=0 nonu nornu
autocmd FileType yate setlocal smartindent
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.js.flow set filetype=javascript
autocmd BufNewFile,BufRead *.jinja2 set syntax=jinja
autocmd BufNewFile,BufRead *.java set syntax=java
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
" autocmd BufWritePre *.py :call CocAction('runCommand', 'python.sortImports')
