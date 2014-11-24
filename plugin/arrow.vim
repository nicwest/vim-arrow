if exists('g:arrow_loaded')
  finish
endif
let g:arrow_loaded = 1

if !exists('g:arrow_num_of_buffers')
  let g:arrow_num_of_buffers = 3
endif

command ArrowNext :call arrow#bnext()
command ArrowSplitNext :call arrow#sbnext()
command ArrowPrevious :call arrow#bNext()
command ArrowSplitPrevious :call arrow#sbNext()
command ArrowRewind :call arrow#brewind()
command ArrowSplitRewind :call arrow#sbrewind()
command ArrowLast :call arrow#blast()
command ArrowSplitLast :call arrow#bslast()
command ArrowModified :call arrow#bmodified()
command ArrowSplitModified :call arrow#sbmodified()
