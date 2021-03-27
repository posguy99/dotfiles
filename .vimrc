" .vimrc

" Marc Wilson (msw@cox.net)

" ---------------------------------------------------------------------------
set nocompatible            " Use Vim defaults (much better!)

" are we gvim?
if has("gui_running")
    colorscheme tolerable
    set visualbell
  else
  " are we vim in a *term?
  if $DISPLAY
    source $VIMRUNTIME/menu.vim
    colorscheme tolerable
    set visualbell
  else
    " nope, we're in console mode
    source $VIMRUNTIME/menu.vim
    colorscheme tolerable
  endif
endif

syntax on                   " always turn syntax highlighting on
set autoread                " re-read a changed file (if WE haven't edited it)
set showcmd                 " show partial command in status line
set noautowrite             " I'll tell you when to write out the file

set bdir=~/.vim/backups     " save all backups in a specific place
set dir=~/.vim/backups      " ditto for the swap files
set backup                  " keep a backup file (please!)
set backupcopy=auto         " to work around stupidity in Debian's global vimrc

" ---------------------------------------------------------------------------
" global settings
set modelines=5             " use vim modelines when found in files
set display=lastline        " make sure we can see all of the last line
set nostartofline           " keep the cursor in current column when possible 
set ruler                   " cursor position in status line
set nowrap                  " real linebreaks only, please
set number                  " line numbers

" provide a mapping to turn wrap on and off
nmap <Leader>nw :set wrap!<cr>

set autoindent              " always set autoindenting on
set nosmartindent           " let filetypes turn smartindent on if they want it

" set as below, we will never be inserting a <tab> unless we do it explicitly
" with <ctrl-v><tab>
set expandtab               " expand tabs to spaces
set tabstop=4               " feels evil, but I'll live with it for now
set shiftwidth=4            " as above, but for autoindent so probably OK

set viminfo=!,'20,\"100,:20,%,n~/.viminfo
                            " read/write a .viminfo file, don't store more
                            " than 100 lines of registers, save globals

set bs=indent,eol,start     " allow backspacing over everything in insert mode
                            " must have start in here or vim is WAY confusing

set listchars=eol:$,tab:>-,extends:>,precedes:<
                            " set markers for end of line and unwrapped lines
set showbreak=+             " Precede continued screen lines with a marker

" ---------------------------------------------------------------------------
" fake the menus into working from the keyboard
set wildmenu                " enhanced command completion
set cpo-=<
set wcm=<C-Z>
map <F4> :emenu <C-Z>

" ---------------------------------------------------------------------------
" search options
set showmatch               " show matching brackets
set ignorecase              " do case-insensitive matching
set smartcase               " make it case-sensitive if there are UC characters
set incsearch               " incremental search
set nohlsearch              " incredibly annoying, I'll tell ya if I want it

" ---------------------------------------------------------------------------
" gui options
set guioptions+=bit         " we want the bottom scrollbar, icon, tearoffs

" this is the default font (when the vera fonts are installed in Debian)
" set guifont=Bitstream\ Vera\ Sans\ Mono\ 10

" alternative choice to match the default GTK font setting as best we can
" (gtk 2.x is using Sans, which vim can't use for obvious reasons)
" set guifont=Bitstream\ Vera\ Sans\ Mono\ 8

" alternative choice (slightly smaller, not so floofy)
" set guifont=Andale\ Mono\ 10

" set guifont=Monotype.com\ 8
set guifont=Bitstream\ Vera\ Sans\ Mono\ 10

" ---------------------------------------------------------------------------
" mouse stuff
set mouse=a                 " always support mouse
set nopaste                 " but start off with paste toggled OFF
set mousehide               " hide the mouse when typing

" <Leader>p and shift-insert will paste the X buffer, even on the command line
nmap <Leader>p i<S-MiddleMouse><ESC>
imap <S-Insert> <S-MiddleMouse>
cmap <S-Insert> <S-MiddleMouse>

" ---------------------------------------------------------------------------
" Key Mappings

" Don't use Ex mode, use Q for formatting
map Q gq
map <F12> gqap
imap <F12> <C-O>:gqap<CR>

" strip spamassassin markup off of an e-mail
map <F8> :%!spamassassin -d<cr>

" change directory to that of current file
" (yes, it's stupid and long, but it conflicts with CVS plugin otherwise)
:nmap <Leader>cfd :cd%:p:h<cr>

" change local directory to that of current file
" (also stupid and long, but matches the one above this way)
:nmap <Leader>lcfd :lcd%:p:h<cr>

" implement toggles for paste mode (doesn't work if involves F10 as in help)
map <F6> :set paste<CR>
map <F7> :set nopaste<CR>
imap <F6> <C-O>:set paste<CR>
imap <F7> <nop>
set pastetoggle=<F7>

" ---------------------------------------------------------------------------
" provide for starting vimsh
" nmap <Leader>sh :source ~/.vim/vimsh.vim<CR>

" ---------------------------------------------------------------------------
" ,cel = "clear empty lines"
" - delete the *contents* of all lines which contain only whitespace.
"   note:  this does not delete lines!
map ,cel :%s/^\s\+$//

" ,del = "delete 'empty' lines"
" - delete all lines which contain only whitespace
"   note:  this does *not* delete empty lines!
map ,del :g/^\s\+$/d

" ,cqel = "clear quoted empty lines"
" Clears (makes empty) all lines which start with '>'
" and any amount of following spaces.
nmap ,cqel :%s/^[>]\+$//
vmap ,cqel  :s/^[><C-I> ]\+$//

" ,ksr = "kill space runs"
" substitutes runs of two or more space to a single space:
nmap ,ksr :%s/  \+/ /g
vmap ,ksr  :s/  \+/ /g

" ,Sel = "squeeze empty lines"
" Convert blocks of empty lines (not even whitespace included)
" into *one* empty line (within current visual):
map ,Sel :g/^$/,/./-j

" ,Sbl = "squeeze blank lines"
" Convert all blocks of blank lines (containing whitespace only)
" into *one* empty line (within current visual):
map ,Sbl :g/^\s*$/,/\S/-j

" ---------------------------------------------------------------------------
" ,E = execute line
map ,E 0/\$<CR>w"yy$:<C-R>y<C-A>r!<C-E>
"
" ,dr = decode/encode rot13 text
vmap ,dr :!tr A-Za-z N-ZA-Mn-za-m

" ---------------------------------------------------------------------------
" Pull the following line to the cursor position
noremap <Leader>J :s/\%#\(.*\)\n\(.*\)/\2\1<CR>

" ---------------------------------------------------------------------------
" autoinsert date specification on <new>
" (remember that means to *type* the characters!)
":iab <new>  " %<CR>" Marc Wilson (msw@cox.net)<CR>" $Date: 2005/03/08 00:18:12 $<CR>
:iab <new>  " Marc Wilson (msw@cox.net)<CR>" $Date: 2005/03/08 00:18:12 $<CR>

" ---------------------------------------------------------------------------
function ReadMan()
    " Assign current word under cursor to a script variable:
    let s:man_word = expand('<cword>')

    " Open a new window:
    :exe ":wincmd n"

    " Read in the manpage for man_word (col -b is for formatting):
    :exe ":r!man " . s:man_word . " | col -b"

    " Goto first line...
    :exe ":goto"

    " and delete it:
    :exe ":delete"

    " finally set file type to 'man':
    :exe ":set filetype=man"
    :exe ":set buftype=nofile"
endfunction

" Map the K key to the ReadMan function:
" map K :call ReadMan()<CR>

" ---------------------------------------------------------------------------
function Delineate(line_char)
" Delinate code, start out a separation marker from current indent
" and extend out to textwidth
  if a:line_char == ""
    let line_char = "-"
  else
    let line_char = a:line_char
  endif

  " Use this to get current indent
  exe 'normal ox'
  let curcol=col(".")
  let currow=line(".")
  " Default to 78 char width if no textwidth
  if &tw < 1
    let numchars = 78 - curcol
  else
    let numchars= &tw - curcol
  endif

  " Init tmpstr so it has indent in it
  let linestr = getline(currow)
  let tmpstr = strpart(linestr, 0, strlen(linestr)-1)

  let charcnt = 1
  while charcnt <= numcharshttp://fy.chalmers.se/~appro/linux/DVD+RW/

    let tmpstr = tmpstr.line_char
    let charcnt = charcnt + 1
  endw

  call setline(currow, tmpstr)
endfunction

map <Leader>dl :call Delineate(0)<CR>

" ---------------------------------------------------------------------------
" status line 
set laststatus=2
if has('statusline')
    " Status line detail: (from Rafael Garcia-Suarez)
    " %f        file path
    " %y        file type between braces (if defined)
    " %([%R%M]%)    read-only, modified and modifiable flags between braces
    " %{'!'[&ff=='default_file_format']}
    "           shows a '!' if the file format is not the platform
    "           default
    " %{'$'[!&list]}    shows a '*' if in list mode
    " %{'~'[&pm=='']}   shows a '~' if in patchmode
    " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
    "           only for debug : display the current syntax item name
    " %=        right-align following items
    " #%n       buffer number
    " %l/%L,%c%V    line number, total number of lines, and column number
    function SetStatusLineStyle()
        if &stl == '' || &stl =~ 'synID'
            let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=#%n %l/%L,%c "
        else
            let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c "
        endif
    endfunc

    call SetStatusLineStyle()
    if has('title')
        set titlestring=%t%(\ [%R%M]%)
    endif

    " we don't want these two here, they belong over in our colorscheme
    " which otherwise resets them for some reason... dunno why.

    " highlight StatusLine    ctermfg=White ctermbg=DarkBlue cterm=bold guibg=#f0ebc7 guifg=#7691a7
    " highlight StatusLineNC  ctermfg=White ctermbg=DarkBlue cterm=NONE guibg=#f0ebc7 guifg=#7691a7
endif

" ---------------------------------------------------------------------------
" yankring
let g:yankring_enabled = 1
let g:yankring_persist = 1
let g:yankring_share_between_instances = 1
let g:yankring_history_dir = '~/.vim'

" ---------------------------------------------------------------------------
" stuff for dbext
let g:dbext_default_type = 'MySQL'
let g:dbext_default_user = 'mwilson'
let g:dbext_default_passwd = '@askb'

let g:dbext_default_host = 'mailhost'
let g:dbext_default_dbname = 'menagerie'

"let g:dbext_default_profile_usual = 'user=mwilson:passwd=avalon:host=mailhost:port=3306'

" ---------------------------------------------------------------------------
" stuff for printdialog
" printdialog launches by default with <Leader>pd
" let g:prd_paperList = "letter,legal,A4"
" let g:prd_paperIdx  = 1
"
" let g:prd_prtDeviceList = "laser,pdf,deskjet932c,deskjet1120c"
" let g:prd_prtDeviceIdx  = 1

" let g:prd_syntaxList = "no,current,default,print_bw,zellner"
" let g:prd_syntaxIdx = 4
"
" let g:prd_duplexList    = "off,long,short"
" let g:prd_duplexIdx = 1

" ---------------------------------------------------------------------------
" stuff for autodate to do CVS-style timestamps
let autodate_format = ': %Y/%m/%d %H:%M:%S '
let autodate_keyword_pre  = '\$Date'
let autodate_keyword_post = '\$'

" ---------------------------------------------------------------------------
" MRU stuff
" let MRU_File = '~/.vim/_vim_mru_files'
let MRU_Max_Entries = 5
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'

" ---------------------------------------------------------------------------
" tagslist
let Tlist_Show_Menu = 1

" ---------------------------------------------------------------------------
" filetype stuff

filetype plugin on

if has('autocmd')
    augroup filetypedetect
        au! BufRead,BufNewFile /var/log/* set filetype=syslog

        " make sure we get sent back to where we were editing before...
        autocmd BufReadPost *
          \ if line("'\"") > 0 |
          \   if line("'\"") <= line("$") |
          \      exe("norm '\"") |
          \    else |
          \      exe "norm $" |
          \   endif |
          \ endif 

        " In text files, always limit the width of text to 78 characters
        autocmd BufRead text set tw=78  

        " turn on spell checking for mail messages
        autocmd BufRead mail setlocal spell spelllang=en_us

        " miscellaneous filetypes
        au BufNewFile,BufRead fstab set filetype=fstab 
        au BufNewFile,BufRead resolv.conf set filetype=resolv
        au BufNewFile,BufRead *.svg set filetype=svg
        au BufNewFile,BufRead passwd set filetype=passwd
        au BufNewFile,BufRead /etc/network/interfaces set filetype=interfaces
    augroup END

    augroup cprog
        " Remove all cprog autocommands
        au!
        " When starting to edit a file:
        "   For *.c and *.h files set formatting of comments and set C-indenting on.
        "   For other files switch it off.
        "   Don't change the order, it's important that the line with * comes first.
        autocmd BufRead *       set formatoptions=tcql nocindent comments&
        autocmd BufRead *.c,*.h set nu formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
    augroup END
    
    " Transparent editing of gpg encrypted files.
    " By Wouter Hanegraaff <wouter@blub.net>
    augroup encrypted
        au!

        " First make sure nothing is written to ~/.viminfo while editing
        " an encrypted file.
        autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
        " We don't want a swap file, as it writes unencrypted data to disk
        autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
        " Switch to binary mode to read the encrypted file
        autocmd BufReadPre,FileReadPre      *.gpg set bin
        autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
        autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
        " Switch to normal mode for editing
        autocmd BufReadPost,FileReadPost    *.gpg set nobin
        autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
        autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

        " Convert all text to encrypted text before writing
        autocmd BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null
        " Undo the encryption so we are back in the normal text, directly
        " after the file has been written.
        autocmd BufWritePost,FileWritePost    *.gpg   u
    augroup END

endif

" ---------------------------------------------------------------------------

" vim: nu tw=0

" $Id: .vimrc,v 1.25 2005/03/08 00:18:12 mwilson Exp mwilson $
