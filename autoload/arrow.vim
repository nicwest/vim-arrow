function! s:all() abort
  return filter(range(1, bufnr('$')), 'bufexists(v:val)')
endfunction

function! s:listed() abort
  return filter(s:all(), 'buflisted(v:val)')
endfunction

function! s:loaded() abort
  return filter(s:all(), 'bufloaded(v:val)')
endfunction

function! s:unloaded() abort
  return filter(s:all(), '!bufloaded(v:val)')
endfunction 

function! s:modified() abort
  return filter(s:listed(), 'getbufvar(v:val, "&mod")')
endfunction

function! s:buffer_names(buffers) abort
  return map(a:buffers, 'bufname(v:val) != "" ? bufname(v:val) : "[No Name]"')
endfunction

function! s:next_buffers(buffers) abort
  let num = g:arrow_num_of_buffers
  let bindex = index(a:buffers, bufnr('%')) 
  if bindex == -1
    let bindex = 0
  endif
  let next = a:buffers[bindex : bindex+num-1]
  if len(next) < num && len(a:buffers) > 1
    let next += a:buffers[0 : min([num - len(next) - 1, bindex])]
  endif
  return next
endfunction

function! s:previous_buffers(buffers) abort
  return s:next_buffers(reverse(a:buffers))
endfunction

function! s:direction_string(buffers, direction_marker) abort
  return 'echon "' . join(s:buffer_names(a:buffers), '" | echohl Directory | echon " '.a:direction_marker.' " | echohl None | echon "').'"'
endfunction

function! arrow#bnext() abort
  silent! exe ':bnext'
  exe s:direction_string(s:next_buffers(s:listed()), '->')
endfunction

function! arrow#sbnext() abort
  silent! exe ':sbnext'
  exe s:direction_string(s:next_buffers(s:listed()), '->')
endfunction

function! arrow#bNext() abort
  silent! exe ':bNext'
  exe s:direction_string(s:previous_buffers(s:listed()), '=>')
endfunction

function! arrow#sbNext() abort
  silent! exe ':sbNext'
  exe s:direction_string(s:previous_buffers(s:listed()), '=>')
endfunction

function! arrow#brewind() abort
  silent! exe ':brewind'
  exe s:direction_string(s:next_buffers(s:listed()), '->')
endfunction

function! arrow#sbrewind() abort
  silent! exe ':sbrewind'
  exe s:direction_string(s:next_buffers(s:listed()), '->')
endfunction

function! arrow#blast() abort
  silent! exe ':blast'
  exe s:direction_string(s:previous_buffers(s:listed()), '=>')
endfunction

function! arrow#sblast() abort
  silent! exe ':sblast'
  exe s:direction_string(s:previous_buffers(s:listed()), '=>')
endfunction

function! arrow#bmodified() abort
  silent! exe ':bmodified'
  exe s:direction_string(s:next_buffers(s:modified()), '+>')
endfunction

function! arrow#sbmodified() abort
  silent! exe ':sbmodified'
  exe s:direction_string(s:next_buffers(s:modified()), '+>')
endfunction
