"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Settings for vundle
set shell=bash   " use of POSIX shell is recommended for Vundle (bash, sh)
set nocompatible " be iMproved, required
filetype off     " required

" set the runtime path to include Vundle and initialize
"set rtp+=/home/pavel/.vim/plugin/Vundle.vim
set rtp+=/home/pavel/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Other plugins here:
Plugin 'ycm-core/YouCompleteMe'
Plugin 'SirVer/ultisnips'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Settings for YouCompleteMe
"""" Configuration for YCM enabling in virtual environments
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/.vim/global_extra_conf.py'

"""" Other settings
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Settings for ultisnips
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other settings
	syntax on
	filetype plugin indent on
	set number
	set autoindent
	set showmatch
	set showmode
	
	" Ctrl-Tab goes to next tab
	map ] :tabnext<CR>
	vmap ] :tabnext<CR>
	" Ctrl-Shift-Tab goes to previous tab
	map [ :tabprev<CR>
	vmap [ :tabprev<CR>

	" Configuration for Perl Support
	let g:Perl_TimestampFormat= '%y%m%d.%H%M%S'
	let perl_include_pod = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto timestamp
	" If buffer modified, update any 'Last modified: ' in the first 20 lines.
	" 'Last modified: Fri Nov 07, 2008  05:00PM
	" Restores position using \s mark.
	function! LastModified()
	  if &modified
	    normal ms
	    let n = min([10, line("$")])
	    exe '1,' . n . 's#^\(.\{,10}Modified: \).*#\1' .
	          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
	    normal `s
	  endif
	endfun
	autocmd BufWritePre *.pl call LastModified()

"|"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"|" Folding
"|	" Basic folds for subs
"|	function GetPerlFold()
"|	  if getline(v:lnum) =~ '^\s*sub\s'
"|	    return ">1"
"|	  elseif getline(v:lnum) =~ '\}\s*$'
"|	    let my_perlnum = v:lnum
"|	    let my_perlmax = line("$")
"|	    while (1)
"|	      let my_perlnum = my_perlnum + 1
"|	      if my_perlnum > my_perlmax
"|	        return "<1"
"|	      endif
"|	      let my_perldata = getline(my_perlnum)
"|	      if my_perldata =~ '^\s*\(\#.*\)\?$'
"|	        " do nothing
"|	      elseif my_perldata =~ '^\s*sub\s'
"|	        return "<1"
"|	      else
"|	        return "="
"|	      endif
"|	    endwhile
"|	  else
"|	    return "="
"|	  endif
"|	endfunction
"|	setlocal foldexpr=GetPerlFold()
"|	setlocal foldmethod=expr
"|
"|""" More folds
"|""" define groups that cannot contain the start of a fold
"|syn cluster vimNoFold contains=vimComment,vimLineComment,vimCommentString,vimString,vimSynKeyRegion,vimSynRegPat,vimPatRegion,vimMapLhs,vimOperParen,@EmbeddedScript
"|syn cluster vimEmbeddedScript contains=vimMzSchemeRegion,vimTclRegion,vimPythonRegion,vimRubyRegion,vimPerlRegion
"|
"|""" fold while loops
"|syn region vimFoldWhile
"|      \ start="\<wh\%[ile]\>"
"|      \ end="\<endw\%[hile]\>"
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ transparent fold
"|      \ keepend extend
"|      \ containedin=ALLBUT,@vimNoFold
"|
"|""" fold for loops
"|"""syn region vimFoldFor
"|"      \ start="\v<for>%(\s*\n\s*\\)?\s*\k+%(\s*\n\s*\\\s*)?\s*<in>"
"|"      \ end="\<endfo\%[r]\>"
"|"      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|"      \ transparent fold
"|"      \ keepend extend
"|"      \ containedin=ALLBUT,@vimNoFold
"|
"|" fold if...else...endif constructs
"|syn region vimFoldIfContainer
"|      \ start="\<if\>"
"|      \ end="\<endif\>"
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ transparent
"|      \ keepend extend
"|      \ containedin=ALLBUT,@vimNoFold
"|      \ contains=NONE
"|syn region vimFoldIf
"|      \ start="\<if\>"
"|      \ end="^\s*\\\?\s*else\%[if]\>"ms=s-1,me=s-1
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ fold transparent
"|      \ keepend
"|      \ contained containedin=vimFoldIfContainer
"|      \ nextgroup=vimFoldElseIf,vimFoldElse
"|      \ contains=TOP
"|syn region vimFoldElseIf
"|      \ start="\<else\%[if]\>"
"|      \ end="^\s*\\\?\s*else\%[if]\>"ms=s-1,me=s-1
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ fold transparent
"|      \ keepend
"|      \ contained containedin=vimFoldIfContainer
"|      \ nextgroup=vimFoldElseIf,vimFoldElse
"|      \ contains=TOP
"|syn region vimFoldElse
"|      \ start="\<else\>"
"|      \ end="\<endif\>"
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ fold transparent
"|      \ keepend
"|      \ contained containedin=vimFoldIfContainer
"|      \ contains=TOP
"|
"|" fold try...catch...finally...endtry constructs
"|syn region vimFoldTryContainer
"|      \ start="\<try\>"
"|      \ end="\<endt\%[ry]\>"
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ transparent
"|      \ keepend extend
"|      \ containedin=ALLBUT,@vimNoFold
"|      \ contains=NONE
"|syn region vimFoldTry
"|      \ start="\<try\>"
"|      \ end="^\s*\\\?\s*\(fina\%[lly]\|cat\%[ch]\)\>"ms=s-1,me=s-1
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ fold transparent
"|      \ keepend
"|      \ contained containedin=vimFoldTryContainer
"|      \ nextgroup=vimFoldCatch,vimFoldFinally
"|      \ contains=TOP
"|syn region vimFoldCatch
"|      \ start="\<cat\%[ch]\>"
"|      \ end="^\s*\\\?\s*\(cat\%[ch]\|fina\%[lly]\)\>"ms=s-1,me=s-1
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ fold transparent
"|      \ keepend
"|      \ contained containedin=vimFoldTryContainer
"|      \ nextgroup=vimFoldCatch,vimFoldFinally
"|      \ contains=TOP
"|syn region vimFoldFinally
"|      \ start="\<fina\%[lly]\>"
"|      \ end="\<endt\%[ry]\>"
"|      \ skip=+"\%(\\"\|[^"]\)\{-}\%("\|$\)\|'[^']\{-}'+
"|      \ fold transparent
"|      \ keepend
"|      \ contained containedin=vimFoldTryContainer
"|      \ contains=TOP
"|
"|
"|let perl_fold=1
"|let perl_fold_blocks=1
"|let g:vimsyn_folding='afp'

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASH Support
let g:BASH_AuthorName   = 'Pavel Svejda'
let g:BASH_AuthorRef    = 'PS'
let g:BASH_Email        = 'pavel_svejda@cz.ibm.com'
let g:BASH_Company      = 'IBM DC Brno'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Working with FOLDING - automated
" (https://til.hashrocket.com/posts/17c44eda91-persistent-folds-between-vim-sessions)
" modified according to: https://vi.stackexchange.com/questions/13864/bufwinleave-mkview-with-unnamed-file-error-32
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup END

set viewoptions=folds,cursor
set sessionoptions=folds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " CAPS LOCK """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch CapsLock behavior on/off by pressing Ctrl-6 (memo: Ctrl-^)
" ...this will work only in editting modes (like Insert, etc.)
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor

" Kill the capslock when leaving insert mode.
autocmd InsertLeave * set iminsert=0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" define LEADER
let mapleader = ","

" General Settings
set cursorline
set cursorcolumn
"colorscheme codeschool_term
colorscheme desert

" for python
"set tabstop=4 expandtab shiftwidth=4 softtabstop=4
set expandtab
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

"set colorcolumn=120
"highlight colorcolumn ctermbg=lightgrey guibg=black

" :inoremap () ()<Esc>i
:inoremap ( ()<Esc>i
:inoremap [ []<Esc>i
:inoremap < <><Esc>i
:inoremap " ""<Esc>i
:inoremap ' ''<Esc>i
:inoremap ," """<CR>"""<Esc>O

noremap Y y$

:nnoremap <Leader>date "=strftime("%Y-%m-%d")<CR>P
:inoremap <Leader>date <C-R>=strftime("%Y-%m-%d")<CR>

:nnoremap <Leader>time "=strftime("%H:%M")<CR>P
:inoremap <Leader>time <C-R>=strftime("%H:%M")<CR>

":nnoremap <Leader>T ":s/"\s*\(\d\d\):\(\d\d\)\s*-\s*\(\d\d\):\(\d\d\)\s*"$/\=( (submatch(3)*60 + submatch(4)) - (submatch(1)*60 + submatch(2)))


" PYTHON specific

" run python3 file
:nnoremap <Leader>r :w<CR>:!python %
"noremap <F5> :w<CR>:!python %<CR>
noremap <F5> :w<CR>:!run_python %<CR>

" add a colon at the end of the line and go to the new line
:inoremap <C-S-CR> <Esc>A:<Esc>o
noremap <C-S-CR> A:<Esc>o

" bunch for 'def', for, if, class
:inoremap <Leader>def def func():<CR>pass<Esc>k^w<C-v>e
":inoremap <Leader>for for var in seq:<CR>pass<Esc>k^w<C-v>e
:inoremap <Leader>if if condition:<CR>pass<Esc>k^w<C-v>e
:inoremap <Leader>try try:<CR>pass<CR>except exception_name as e:<CR>pass<Esc>k^w<C-v>e

" replacement for <Esc>
:inoremap jk <esc>
:inoremap kj <esc>

" ---- commentars ON for python -----
" eg. <c-n> i# / <c-n> x == toggle comment on/off at the beginning of line
:vnoremap <C-n> :norm 
:vnoremap <Leader>c :norm i#<CR>
:vnoremap <Leader>x :norm x<CR>
" ---
:inoremap <Leader>c <Esc>mpv:norm i#<CR>`pla
:inoremap <Leader>x <Esc>mpv:norm x<CR>`pha
" ---
:noremap <Leader>c mpv:norm i#<CR>`pl
:noremap <Leader>x mpv:norm x<CR>`ph
