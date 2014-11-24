Vim-Arrow
=========

Previews the next buffers when paging through buffers (:bnext :bprevious etc).

![vim-arrow](https://cloud.githubusercontent.com/assets/794070/5165088/d5d56b6c-73d7-11e4-9cb8-f6af117da6c3.gif)

Suggested-mappings
------------------

```viml
nnoremap <silent>]b :ArrowNext<CR>
nnoremap <silent>[b :ArrowPrevious<CR>
nnoremap <silent>]B :ArrowSplitNext<CR>
nnoremap <silent>[B :ArrowSplitPrevious<CR>
nnoremap <silent>]q :ArrowModified<CR>
nnoremap <silent>]Q :ArrowSplitModified<CR>
nnoremap <silent>]r :ArrowRewind<CR>
nnoremap <silent>]R :ArrowSplitRewind<CR>
nnoremap <silent>]l :ArrowLast<CR>
nnoremap <silent>]L :ArrowSplitLast<CR>
```
