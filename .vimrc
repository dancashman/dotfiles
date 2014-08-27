
" Vim mode
set nocompatible

" Hide buffers, don't close them
set hidden

" Initialize vundle plugin manager
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Vundle plugins
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
Bundle 'reinh/vim-makegreen'
Bundle 'shougo/neocomplcache'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'myusuf3/numbers.vim'
Bundle 'fs111/pydoc.vim'
Bundle 'mattcaldwell/python-imports.vim'
" Bundle 'ervandew/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'twilight'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'einars/js-beautify'
Bundle 'wookiehangover/jshint.vim'
Bundle 'kien/ctrlp.vim'

Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'

function! g:ToggleLineNumberMode()
    if(&nu==1)
        set rnu
    elseif(&rnu==1)
        set nornu
    else
        set nu
    endif
endfunc

" Indent based on filetype
filetype plugin indent on

" Syntax highlighting and color scheme
syntax on
" colorscheme twilight
colorscheme Tomorrow-Night-Bright

" Customize leader
let mapleader = ','

" Autocompletion
if has('autocmd')
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
endif
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabNoCompleteAfter = ['^', '\s']
set completeopt=menuone,longest,preview

" Basic editor settings (and PEP8)
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set autoindent
set copyindent
set ignorecase
set smartcase
set smarttab
set nowrap
set cursorline

set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class
set title
set visualbell
set noerrorbells

" Backups and swap files
silent !mkdir ~/tmp > /dev/null 2>&1
set backup
set swapfile
set backupdir=~/tmp
set dir=~/tmp

" Mappings -----------------------------------------
"
" display file explorer
map <C-d> :NERDTreeToggle<CR>
" display tags
map <C-t> :TagbarToggle<CR>
" toggle absolute/relative line numbers
map <C-n> :call g:ToggleLineNumberMode()<CR>
" clear highlighting
map <C-g> :noh<CR>
" clear search
map <C-s> :let @/ = ""<CR>
" toggle list
map <C-l> :set list!<CR>
" django tests
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>
" django server
map <leader>rs :set makeprg=python\ manage.py\ runserver<CR>
" window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" jsbeautify
map <c-f> :call JsBeautify()<cr>
" or
" autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
" autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
" autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" CtrlP Settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux


" End Mappings -------------------------------------

" Status Line
set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " git branch
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

" Search
set hlsearch
set incsearch

" Whitespace
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
if has('autocmd')
    autocmd filetype html,xml set listchars-=tab:>.
endif

" Toggle paste mode
set pastetoggle=<F2>

" Forget to sudo?
cmap w!! w !sudo tee % >/dev/null

" Adjust file types
au BufNewFile,BufRead admin.py     setlocal filetype=python.django
au BufNewFile,BufRead urls.py      setlocal filetype=python.django
au BufNewFile,BufRead models.py    setlocal filetype=python.django
au BufNewFile,BufRead views.py     setlocal filetype=python.django
au BufNewFile,BufRead settings.py  setlocal filetype=python.django
au BufNewFile,BufRead forms.py     setlocal filetype=python.django

" Python
" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
python << EOF
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

    for strLine in vim.current.buffer:
        if strLine == "import pdb":
            break
    else:
        vim.current.buffer.append( 'import pdb', 0)
        vim.command( 'normal j1')

vim.command( 'map <leader>b :py SetBreakpoint()<cr>')
EOF

" Auto-import
" let g:PythonAutoAddImports = 1

" Indent Guides
:let g:indent_guides_guide_size = 1
:let g:indent_guides_start_level = 2

" Syntastic
let g:syntastic_check_on_open = 1

" NerdTree
let g:NERDTreeWinSize = 40
let NERDTreeShowHidden=1 "Show hidden files in NerdTree
"autopen NERDTree and focus cursor in new document
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

" vim-javascript
let javascript_enable_domhtmlcss = 1

