au BufNewFile,BufRead *.ml set sb
au BufNewFile,BufRead *.ml map <F11> :split /tmp/ocaml \| %d \|setlocal ft=omlet \| setlocal autowrite \| r!ocaml < # <CR>
au BufNewFile,BufRead *.ml map <F12> :QuickRun<CR>

"au BufNewFile,BufRead *.ml map <F12> :dr /tmp/ocaml \| %d \|setlocal ft=omlet \|setlocal autowrite \| r!ocaml < # <CR>
