set encoding=utf-8                    " In case $LANG doesn't have a sensible value.

syntax on                             " Syntax highlighting.
set background=dark                   " Inquiring plugins want to know.
color blackboard                      " Default color scheme.
"colorscheme koehler

set backspace=indent,eol,start        " Allow backspacing over everything in insert mode.
set fillchars=vert:\                  " No pipes in vertical split separators.
set laststatus=2                      " Always show status bar.
set listchars=nbsp:·,tab:▸\ ,trail:·,eol:¬  " Configure how invisibles appear.
set list                              " Show invisibles.
set nomodeline                        " Modelines have had serious security issues. If you turn this on, make sure you know what you're doing.
set nojoinspaces                      " 1 space, not 2, when joining sentences.
set number                            " Show gutter with line numbers.
set scrolloff=1                       " Minimum number of lines to always show above/below the caret.
set showcmd                           " Show partially typed command sequences.
set showmode
set visualbell                        " Don't beep.
set wildmode=longest,list             " Autocompleting files: prompt, don't autopick.
set wrap                              " Soft wrap.

" Indentation.
set expandtab                         " Replace tabs with spaces.
set shiftwidth=4                      " Spaces used for autoindent and commands like >>.
set softtabstop=4                     " Spaces inserted by <Tab>.

" Searching.
set gdefault                          " Global search by default (/g turns it off).
set hlsearch                          " Highlight results.
set incsearch                         " Search-as-you-type.
set ignorecase smartcase              " Case-insensitive unless we include uppercase.
set shortmess-=S                      " Show result counts like '[1/4]'. Vim 8.1.1270+.

set ruler                             " Show line and column number at bottom of window

set wrapscan
set linebreak
set fileformat=unix
set fileformats=unix

set wrapmargin=0
set textwidth=79

set tabstop=4
set smarttab
set autoindent
set smartindent

" Switch on syntax highlighting.
" To get proper effect set background before setting syntax on
syntax enable


so $VIMRUNTIME/mswin.vim
noremap <C-I> <C-A>
noremap <C-G> <C-Q>

let python_highlight_all=1


" Can autocomplete CSS classes etc with dashes.
" Also changes the "w" small word motion not to stop at dashes,
" but use https://github.com/henrik/CamelCaseMotion for that.
set iskeyword+=-

" More persistent command history.
set history=10000

" Hide away backup and swap files.
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Reload file without prompting if it has changed on disk.
" Will still prompt if there is unsaved text in the buffer.
set autoread
" MacVim checks for autoread when it gains focus; terminal Vim
" must trigger checks. Do so when switching buffers, or after
" 2 secs (the value of updatetime) of pressing nothing.
set updatetime=2000
au WinEnter,BufWinEnter,CursorHold * silent! checktime

" Automatically save changes before switching buffer with some
" commands, like :cnfile.
set autowrite

" Autosave.
" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
au BufLeave,FocusLost * silent! wa

" Treat Nunjucks as HTML. (Templates used with e.g. the Eleventy blog engine.)
au BufRead,BufNewFile *.njk setfiletype html

"Flagging Unnecessary Whitespace
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"For snakefiles used by Snakemake
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

"Set spell for non-code files
autocmd BufRead,BufNewFile *.md,*.tex,*.txt setlocal spell

set exrc   " Enable per-directory .vimrc files.
set secure " Disable unsafe commands in per-directory .vimrc files.

" allow selection by mouse etc in non GUI mode
set mouse=a

" Hide the mouse pointer while typing
set mousehide

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Use F12 to enclose selection by $$
map <F12> `$ 
map <F11> ciw'Ctrl+r"'


"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>


" TMUX specific START HERE

"use arrow keys to start selection with shift pressed
"and end selection with shift released
set keymodel=startsel,stopsel

" http://snk.tuxfamily.org/log/vim-256color-bce.html
" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
if &term =~ '256color'
  set t_ut=
  endif

if &term =~ '^screen'
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" TMUX specific end here
