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

function! s:short_names(buffers) abort
  let l:bufnames = {}
  for l:bname in s:buffer_names(a:buffers)
    let l:bfile =  fnamemodify(l:bname, ":t")
    if has_key(l:bufnames, l:bfile)
      call add(l:bufnames[l:bfile], l:bname) 
    else
      let l:bufnames[l:bfile] = [l:bname]
    endif
  endfor
  let l:short_names = {}
  for [key, value] in items(l:bufnames)
    if value[0] == '[No Name]'
      let l:short_names[value[0]] = value[0]
    elseif len(value) == 1
      let l:short_names[value[0]] = key
    else 
      let l:split_names = map([]+value, 'split(v:val, "/")')
      let l:split_names_len = map([]+l:split_names, 'len(v:val)') 
      let l:max_len = max(split_names_len)
      let l:max_len_split = l:split_names[index(l:split_names_len, l:max_len)]
      let l:shorter_splits = filter([] + l:split_names, 'v:val != l:max_len_split')
      let chunk_index = 0
      while len(l:max_len_split) > 0
        let l:chunk = l:max_len_split[0]
        let l:is_same = map([] + l:shorter_splits, 'v:val[chunk_index] == l:chunk')
        if index(l:is_same, 0) > -1
          break
        endif
        let l:max_len_split = l:max_len_split[1:]
        let l:chunk_index += 1
      endwhile
      for [l:name, l:split_name] in map(value, '[v:val, get(l:split_names, v:key)]')
        let l:short_names[l:name] = join(l:split_name[chunk_index :], '/')
      endfor
    endif
  endfor
  return map(a:buffers, 'get(l:short_names, v:val)')
endfunction

function! s:next_buffers(buffers) abort
  let num = g:arrow_num_of_buffers
  let bindex = index(a:buffers, bufnr('%')) 
  if bindex == -1
    let bindex = 0
  endif
  let next = a:buffers[bindex : bindex+num-1]
  if len(next) < num && len(a:buffers) > len(next)
    let next += a:buffers[0 : max([min([min([num, len(a:buffers)]) - len(next) -1, bindex]), 0])]
  endif
  return next
endfunction

function! s:previous_buffers(buffers) abort
  return s:next_buffers(reverse(a:buffers))
endfunction

function! s:direction_string(buffers, direction_marker) abort
  return 'echon "' . join(s:short_names(a:buffers), '" | echohl Directory | echon " '.a:direction_marker.' " | echohl None | echon "').'"'
endfunction

function! arrow#bnext() abort
  silent! bnext
  exe s:direction_string(s:next_buffers(s:listed()), '->')
endfunction

function! arrow#sbnext() abort
  silent! vert sbnext
  exe s:direction_string(s:next_buffers(s:listed()), '->')
endfunction

function! arrow#bNext() abort
  silent! bNext
  exe s:direction_string(s:previous_buffers(s:listed()), '=>')
endfunction

function! arrow#sbNext() abort
  silent! vert sbNext
  exe s:direction_string(s:previous_buffers(s:listed()), '=>')
endfunction

function! arrow#brewind() abort
  silent! brewind
  exe s:direction_string(s:next_buffers(s:listed()), '->')
endfunction

function! arrow#sbrewind() abort
  silent! vert sbrewind
  exe s:direction_string(s:next_buffers(s:listed()), '->')
endfunction

function! arrow#blast() abort
  silent! blast
  exe s:direction_string(s:previous_buffers(s:listed()), '=>')
endfunction

function! arrow#sblast() abort
  silent! vert sblast
  exe s:direction_string(s:previous_buffers(s:listed()), '=>')
endfunction

function! arrow#bmodified() abort
  silent! bmodified
  exe s:direction_string(s:next_buffers(s:modified()), '+>')
endfunction

function! arrow#sbmodified() abort
  silent! vert sbmodified
  exe s:direction_string(s:next_buffers(s:modified()), '+>')
endfunction
