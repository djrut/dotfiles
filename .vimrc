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
let python_highlight_all=1
colorscheme monokai 
" }}}
" Line numbering {{{
"
set relativenumber
set number
set numberwidth=5
set cpoptions+=n
" }}}
" Tab/Indent settings {{{
"
set tabstop=4         " number of visual spaces per TAB
set shiftwidth=4      " 
set softtabstop=4     " number of spaces in tab when editing
set expandtab         " tabs are spaces
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
" move vertically by visual line
nnoremap j gj
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
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
" space open/closes folds
nnoremap <space> za
" Toggle relative line numbering
nnoremap <leader>l :setlocal relativenumber!<CR>
" Enable easy paste toggling
nnoremap <leader>p :set invpaste paste?<CR>
" Tag Bar
nnoremap <leader>t :TagbarToggle<CR>
" Invoke ctags
nnoremap <leader>T :!ctags -R .<CR>
" Nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>
" save session
nnoremap <leader>S :mksession<CR>
" Toggle Syntastic
nnoremap <leader>s :SyntasticToggleMode<CR>
" Run Syntastic check
nnoremap <leader>sc :SyntasticCheck<CR>
" Jump to keyword definition
nnoremap <leader>gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Show change window
nnoremap <leader>c :changes<CR>
" Invoke compiler
nnoremap <leader>m :make<CR>
" Invoke Grepper with ack
nnoremap <leader>g :Grepper -tool ag -noswitch -highlight <cr>
" Invoke Grepper with ack for current selection/focus
nnoremap <leader>* :Grepper -tool ag -cword -noprompt -noswitch -highlight<cr>
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
" Folding settings {{{
" 
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10
set foldmethod=indent   " fold based on indent level
" }}}
" DelimitMate {{{
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" }}}
" vim-rooter {{{
let g:rooter_manual_only = 1
let g:rooter_patterns = ['pom.xml','.git/']
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
"CtrlP {{{
" 
let g:ctrlp_map = '<leader>.'
let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr|svn)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
" }}}
" Airline {{{
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2
" }}}
" Syntastic {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': []  }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
" }}}
" YouCompleteMe settings  {{{
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_python_binary_path = 'python'
" }}}
" Plugin configuration {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'vundlevim/vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'moll/vim-node'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'majutsushi/tagbar'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'mhinz/vim-grepper'
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-dispatch'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-function'
Plugin 'kana/vim-textobj-line'
Plugin 'airblade/vim-gitgutter'
Plugin 'airblade/vim-rooter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'valloric/youcompleteme'
Plugin 'ternjs/tern_for_vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'bling/vim-airline'
Plugin 'glench/vim-jinja2-syntax'
Plugin 'digitalrounin/vim-yaml-folds'
Plugin 'raimondi/delimitmate'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tmux-plugins/vim-tmux-focus-events'
call vundle#end()            " required
" }}}
" Functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
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
