" Function to allow to go to line number when a file is open
function! s:gotoline()
    let file = bufname("%")
    let names =  matchlist( file, '\(.*\):\(\d\+\)')

    if len(names) != 0 && filereadable(names[1])
        let l:bufn = bufnr("%")
        exec ":e " . names[1]
        exec ":" . names[2]
        exec ":bdelete " . l:bufn
        if foldlevel(names[2]) > 0
            exec ":foldopen!"
        endif
    endif
endfunction

" Call function when character ':' is founded
autocmd! BufNewFile *:* nested call s:gotoline()

" Highlight whitespace problems.
" flags is '' to clear highlighting, or is a string to
" specify what to highlight (one or more characters):
"   e  whitespace at end of line
"   i  spaces used for indenting
"   s  spaces before a tab
"   t  tabs not at start of line
function! ShowWhitespace(flags)
  let bad = ''
  let pat = []
  for c in split(a:flags, '\zs')
    if c == 'e'
      call add(pat, '\s\+$')
    elseif c == 'i'
      call add(pat, '^\t*\zs \+')
    elseif c == 's'
      call add(pat, ' \+\ze\t')
    elseif c == 't'
      call add(pat, '[^\t]\zs\t\+')
    else
      let bad .= c
    endif
  endfor
  if len(pat) > 0
    let s = join(pat, '\|')
    exec 'syntax match ExtraWhitespace "'.s.'" containedin=ALL'
  else
    syntax clear ExtraWhitespace
  endif
  if len(bad) > 0
    echo 'ShowWhitespace ignored: '.bad
  endif
endfunction
autocmd! BufNewFile * nested call ShowWhitespace('e')

function! ToggleShowWhitespace()
  if !exists('b:ws_show')
    let b:ws_show = 0
  endif
  if !exists('b:ws_flags')
    let b:ws_flags = 'est'  " default (which whitespace to show)
  endif
  let b:ws_show = !b:ws_show
  if b:ws_show
    call ShowWhitespace(b:ws_flags)
  else
    call ShowWhitespace('')
  endif
endfunction

nnoremap <Leader>ws :call ToggleShowWhitespace()<CR>
highlight ExtraWhitespace ctermbg=darkred guibg=darkred

set background=dark
syntax on
let c_space_errors=1
let java_space_errors = 1
" set textwidth=80

" all the new tab characters entered will be changed to spaces
set expandtab
" control how many columns text is indented with the reindent
" operations (<< and >>) and automatic C-style indentation
set shiftwidth=4
" control how many columns vim uses when you hit Tab in insert mode
set softtabstop=4
" tell vim how many columns a tab counts for
set tabstop=4

set nu
set foldmethod=marker

set ws

" add mouse control in tmux
set ttymouse=xterm2
set mouse=a

map ,# :s/^/#/<CR>
" color monokai
syntax enable
colorscheme monokai

set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'

call vundle#end()            " required
filetype plugin indent on    " required
