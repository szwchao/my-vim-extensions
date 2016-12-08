scriptencoding utf-8
" =============================================================================
" File:           autoload/ctrlp/mdimg.vim
" Description:    Custom command for CtrlP
" =============================================================================

if (exists('g:loaded_ctrlp_mdimg') && g:loaded_ctrlp_mdimg)
            \ || v:version < 700 || &cp
    finish
endif
let g:loaded_ctrlp_mdimg = 1

call add(g:ctrlp_ext_vars, {
            \ 'init': 'ctrlp#mdimg#init()',
            \ 'accept': 'ctrlp#mdimg#accept',
            \ 'exit': 'ctrlp#mdimg#exit()',
            \ 'lname': 'markdown_image',
            \ 'sname': 'markdown_image',
            \ 'type': 'line',
            \ 'sort': 0,
            \ 'specinput': 0,
            \ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#mdimg#init()
    let s:lst = []
    let path = getcwd() . '/image'
    if !isdirectory(path)
        let s:errmsg = 'No image directory in current folder'
        return []
    endif
    for fname in split(globpath(path, '/*.*'), '\n')
        call add(s:lst, fnamemodify(fname, ':t'))
    endfor
    return s:lst
endfunction

function! ctrlp#mdimg#accept(mode, str)
    call ctrlp#exit()
    let alt_name = input("Alt name: ")
    if !len(alt_name)
        let img_url = "![](./image/" . a:str .")"
    else
        let img_url = "![" . alt_name . "](./image/" . a:str .")"
    endif
    execute ":normal i" . img_url
    if a:mode == 'i'
        call feedkeys('a')
    endif
endfunction

function! ctrlp#mdimg#exit()
endfunction

function! ctrlp#mdimg#id()
    return s:id
endfunction

" TODO 从剪贴板复制图片到image目录下并插入
function! ctrlp#mdimg#create()
    let image_name = input("Save image from clipboard: ")
    let path = getcwd() . '/image'
python << EOF
import sys, os, vim
from PIL import ImageGrab
im = ImageGrab.grabclipboard()
if im:
    im.save('somefile.png','PNG')
EOF
endfunction

