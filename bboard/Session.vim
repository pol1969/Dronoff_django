let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/bbc
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +37 bboard/main/templates/layout/basic.html
badd +1 bboard/main/templates/main/register_user.html
badd +1 bboard/main/templates/main/register_done.html
badd +21 bboard/main/models.py
badd +15 bboard/main/utilities.py
badd +1 bboard/main/templates/main/email/activation_letter_subject.txt
badd +7 bboard/main/templates/main/email/activation_letter_body.txt
badd +9 bboard/main/views.py
badd +3 bboard/main/urls.py
badd +1 bboard/main/templates/main/activation_done.html
badd +8 bboard/main/templates/main/bad_signature.html
badd +12 bboard/main/templates/main/user_is_activated.html
badd +2 bboard/main/forms.py
argglobal
silent! argdel *
edit bboard
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winminwidth=1 winheight=1 winwidth=1
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 2 - ((1 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 0
lcd ~/bbc/bboard
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
