" =============================================================================
" File:           autoload/ctrlp/cmd.vim
" Description:    Custom command for CtrlP
" =============================================================================

if (exists('g:loaded_ctrlp_cmd') && g:loaded_ctrlp_cmd)
            \ || v:version < 700 || &cp
    finish
endif
let g:loaded_ctrlp_cmd = 1

let s:cmd_list = 
            \[
            \ ['文件另存到桌面'                , ':call SaveCurrentFileToDesktop()'                 , 1] ,
            \ ['复制文件名'                    , ':let @+=expand("%:t")'                            , 1] ,
            \ ['复制文件名(包括路径)'          , ':let @+=expand("%:p")'                            , 1] ,
            \ ['设置cpp的tag'                  , ':set tags+=' . $VIM . '/tools/tags/cpp'           , 1] ,
            \ ['删除回车符^M'                  , ':%s/\r//g'                                        , 1] ,
            \ ['删除行尾空格'                  , ':%s/\s\+$//g'                                     , 1] ,
            \ ['压缩多行空行为一行'            , ':%s/\(\s*\n\)\+/\r/'                              , 0] ,
            \ ['插入日期和时间'                , ':call InsertDateTime()'                           , 1] ,
            \ ['单词首字母大写'                , ':%s/\w*/\u&/g'                                    , 0] ,
            \ ['宏定义替换为大写'              , ':g/^\s*#define/s/\s\+\zs.\+\ze\s\+.\+$/\U&/g'     , 0] ,
            \ ['大写所有句子的第一个字母'      , ':%s/[.!?]\_s\+\a/\U&\E/g'                         , 0] ,
            \ ['显示所有匹配<p>行'             , ':g/<p>/z#.5|echo "=========="'                    , 0] ,
            \ ['插入行号'                      , ':g/^/exec "s/^/".strpart(line(".")."    ", 0, 4)' , 0] ,
            \ ['删除所有的空行'                , ':g/^\s*$/d'                                       , 0] ,
            \ ['删除所有的匹配<p>行'           , ':g/<p>/d'                                         , 0] ,
            \ ['拷贝所有的匹配<p>行到文件末尾' , ':g/<p>/t$'                                        , 0] ,
            \ ['拷贝所有的匹配<p>行到寄存器a'  , '0"ay0:g/<p>/y A'                                  , 0] ,
            \ ['删除重复行'                    , ':%s/^\(.*\)\n\1/\1$/'                             , 0] ,
            \ ['替换1->2'                      , ':%s/\<1\>/2/g'                                    , 0] ,
            \ ['查找3行空行'                   , '/^\n\{3}'                                         , 1] ,
            \]

call add(g:ctrlp_ext_vars, {
            \ 'init': 'ctrlp#cmd#init()',
            \ 'accept': 'ctrlp#cmd#accept',
            \ 'lname': 'commands',
            \ 'sname': 'commands',
            \ 'type': 'line',
            \ 'sort': 0,
            \ 'specinput': 0,
            \ })

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

function! ctrlp#cmd#init()
    let s:lst = []
    for item in s:cmd_list
        call add(s:lst, item[0])
    endfor
    return s:lst
endfunction

function! ctrlp#cmd#accept(mode, str)
    call ctrlp#exit()
    let i = index(s:lst, a:str)
    if s:cmd_list[i][2] == 1
        call feedkeys(s:cmd_list[i][1] . "\<CR>", 'n')
    else
        call feedkeys(s:cmd_list[i][1], 't')
    endif
endfunction

function! ctrlp#cmd#id()
    return s:id
endfunction
