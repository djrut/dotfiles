" Plugin configuration {{{
" Detect if Vimplug is present and install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif
"
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'crusoexia/vim-monokai'
Plug 'majutsushi/tagbar', { 'on':  'TagbarToggle'  }
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'bling/vim-airline'
Plug 'raimondi/delimitmate'
Plug 'christoomey/vim-system-copy'
Plug 'leissa/vim-acme'
Plug 'gioele/vim-autoswap'
Plug 'moll/vim-bbye'
Plug 'hashivim/vim-terraform'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asyncrun.extra'
Plug 'preservim/vimux'
" Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()
" }}}
" Features {{{
"
set nocompatible                        " We're running Vim, not Vi!
set encoding=utf-8
syntax on                               " Enable syntax highlighting
filetype plugin on               " Enable filetype-specific plugins
filetype indent on               " Enable filetype-specific plugins
filetype on
packadd! matchit
" }}}
" UI Config {{{
"
set showcmd
set cursorline
set colorcolumn=80
set lazyredraw
set showmode
set backspace=indent,eol,start
set browsedir=buffer                  " browse files in same dir as open file
set path+=**
set wildmenu                          " Enhanced command line completion.
set wildmode=list:longest,full        " Complete files using a menu AND list
set wildignorecase
set wildignore+=.git,.hg,.svn
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*.gem
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*.swp,.lock,.DS_Store,._*
" }}}
" Colors {{{
"
set t_Co=256
set background=dark
colorscheme monokai 
let python_highlight_all=1
" }}}
" Line numbering {{{
"
set number
set numberwidth=5
set cpoptions+=n
" }}}
" Tab/Indent settings {{{
"
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
" }}}
" Buffers and splits {{{
"
set splitbelow                        " splits open below the current window by default
set splitright                        " splits open to the right of current window by default
set fillchars=vert:│                  " Vertical sep for splits (unicode bar)
set hidden                            " remember undo after quitting
set switchbuf=useopen                 " reveal already opened files from the quickfix window instead of opening new buffers
set nostartofline                     " "
" }}}
" Keyboard Mappings {{{
"
nnoremap k gk

" Window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     :cp<CR>
noremap   <Down>   :cn<CR>
noremap   <Left>   :lprev<CR>
noremap   <Right>  :lnext<CR>

" Fast Alt key mappings section
"
" Invoke FuzzyFind for files
execute "set <M-f>=\ef"
nnoremap <M-f> :Files<CR>
" Invoke FuzzyFind for tags
execute "set <M-t>=\et"
nnoremap <M-t> :Tags<CR>
" Invoke FuzzyFind for buffers
execute "set <M-b>=\eb"
nnoremap <M-b> :Buffers<CR>
" Invoke Grepper with ack
execute "set <M-g>=\eg"
nnoremap <M-g> :Grepper -tool ag -noswitch -highlight <cr>
" Enable easy paste toggling
execute "set <M-p>=\ep"
nnoremap <M-p> :call TogglePaste()<CR>
" Toggle ALE
execute "set <M-a>=\ea"
nnoremap <M-a> :ALEToggle<CR>
" Close Quickfix window
execute "set <M-x>=\ex"
nnoremap <M-x> :cclose<CR>
" Show change window
execute "set <M-c>=\ec"
nnoremap <M-c> :changes<CR>
" Close buffer maintaining layout
execute "set <M-q>=\eq"
nnoremap <M-q> :Bdelete<CR>
" space open/closes folds
nnoremap <space> za
" Leader key mappings
"
" Toggle relative line numbering
nnoremap <leader>l :setlocal relativenumber!<CR>
" Tag Bar
nnoremap <leader>t :TagbarToggle<CR>
" Invoke ctags
nnoremap <leader>ct :AsyncRun ctags -R $VIRTUAL_ENV .<CR>
" save session
nnoremap <leader>S :mksession<CR>
" Run Syntastic check
nnoremap <leader>gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Invoke compiler
nnoremap <leader>m :make<CR>
" Invoke Grepper with ack for current selection/focus
nnoremap <leader>* :Grepper -tool ag -cword -noprompt -noswitch -highlight<cr>

" Buffer delete without messing with split panes
nnoremap <C-c> :Bdelete<CR>

" Skip quickfix when switching boffers
nnoremap <Tab> :call BSkipQuickFix("bn")<CR>
nnoremap <S-Tab> :call BSkipQuickFix("bp")<CR>

" }}}
" Airline  {{{
"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1			" enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'	" show just the filename	
set gfn=Droid\ Sans\ Mono\ for\ Powerline:h12
" }}}
" Search settings {{{
"
set ignorecase
set smartcase
set wrapscan            " searches wrap around start of file
set showmatch
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" }}}
" FuzzyFind settings {{{
"
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~30%' }

" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
" }}}
" Grepper settings {{{
"
" Maps the operator for normal and visual mode.
" In normal mode, the operator gs takes any motion and uses that selection to populate the search prompt. The query is quoted automatically.
" Useful examples are gsW, gsiw, or gsi".
" In visual mode, it uses the current selection.
"
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
let g:grepper = {}            " initialize g:grepper with empty dictionary
runtime plugin/grepper.vim    " initialize g:grepper with default values
let g:grepper.quickfix = 1
" }}}
" Folding settings {{{
" 
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10
set foldmethod=indent   " fold based on indent level
" }}}
" DelimitMate {{{
let delimitMate_offByDefault = 1
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" }}}
" Autocommands {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal nolist
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd Filetype java set makeprg=javac\ %
    autocmd Filetype java set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd Filetype javascript set makeprg=jshint\ %
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType ruby compiler ruby
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python set makeprg=python\ %
    autocmd FileType json set autoindent
    autocmd FileType json set formatoptions=tcq2l
    autocmd FileType json set textwidth=78 shiftwidth=2
    autocmd FileType json set softtabstop=2 tabstop=8
    autocmd FileType json set expandtab
    autocmd FileType json set foldmethod=syntax
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " autocmd BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim
    autocmd BufNewFile,BufRead *.asm set syntax=acme.vim
augroup END
" }}}
" tmux settings {{{
" allows cursor change in tmux mode
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}
" Airline {{{
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1
set laststatus=2
" }}}
" ALE {{{
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
highlight ALEError ctermbg=DarkRed
highlight ALEWarning ctermbg=LightRed
" let g:ale_completion_enabled = 1
" }}}
" YouCompleteMe settings  {{{
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_python_interpreter_path = '/usr/local/bin/python3'
" }}}
" Functions {{{
" Exclude quickfx when swtching buffers
function! BSkipQuickFix(command)
  let start_buffer = bufnr('%')
  execute a:command
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    execute a:command
  endwhile
endfunction

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

function! TogglePaste()
  set invpaste paste?
  set expandtab
endfunc


" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}
" Metadata {{{
" vim:foldmethod=marker:foldlevel=0
" }}}
