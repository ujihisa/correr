if !has('clientserver')
  echo 'Correr needs +clientserver'
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

function! correr#send(cmd)
  if s:correr_is_working
    return
  endif

  let s:correr_is_working = 1
  call correr#open_result_window()
  normal! ggdG
  call append(0, ':-D')
  wincmd p

  let s:tmpfile = "/tmp/correr.txt"
  let vim = "/Users/ujihisa/git/MacVim/src/MacVim/build/Release/MacVim.app/Contents/MacOS/Vim" " FIXME
  let msg_send = printf("%s --remote-expr 'Correr\\#receive(\"%s\")'", vim, s:tmpfile)
  silent execute printf("!((%s) >& %s; %s) &", a:cmd, s:tmpfile, msg_send)
endfunction

function! Correr#receive(filename)
  call correr#open_result_window()
  normal! ggdG
  call append(0, readfile(a:filename))
  silent normal! gg
  wincmd p
  let s:correr_is_working = 0
endfunction

" From quickrun.vim
function! correr#open_result_window()
  if !exists('s:bufnr')
    let s:bufnr = -1  " A number that doesn't exist.
  endif
  if !bufexists(s:bufnr)
    "execute self.expand(self.config.split) 'split'
    execute 'split'
    edit `='[Correr Output]'`
    let s:bufnr = bufnr('%')
    setlocal bufhidden=hide buftype=nofile noswapfile nobuflisted
    setlocal filetype=correr
  elseif bufwinnr(s:bufnr) != -1
    execute bufwinnr(s:bufnr) 'wincmd w'
  else
    execute 'sbuffer' s:bufnr
  endif
endfunction

let s:correr_is_working = 0
command! -nargs=1 -complete=shellcmd Correr call correr#send(<q-args>)

nnoremap <Space>l :<C-u>Correr<Space>

let &cpo = s:save_cpo
unlet s:save_cpo
