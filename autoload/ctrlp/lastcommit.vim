if exists('g:loaded_ctrlp_lastcommit') && g:loaded_ctrlp_lastcommit
  finish
endif
let g:loaded_ctrlp_lastcommit = 1

let s:lastcommit_var = {
\  'init':   'ctrlp#lastcommit#init()',
\  'exit':   'ctrlp#lastcommit#exit()',
\  'accept': 'ctrlp#acceptfile',
\  'lname':  'lastcommit',
\  'sname':  'lastcommit',
\  'type':   'path',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:lastcommit_var)
else
  let g:ctrlp_ext_vars = [s:lastcommit_var]
endif

let s:self_path = expand("<sfile>")

function! ctrlp#lastcommit#init()
  return split(system('git show --pretty="format:" --name-only'), "\n")
endfunc

function! ctrlp#lastcommit#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#lastcommit#id()
  return s:id
endfunction
