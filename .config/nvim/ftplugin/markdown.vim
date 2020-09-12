" Easily insert images into markdown
nnoremap <buffer> <C-P> :ImagePaste<space>
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

" Soft wrap words
setlocal wrap linebreak

" Set line limit to 75 characters
setlocal textwidth=78

" Disable line numbers
setlocal nonumber norelativenumber

" Conceal bolds and italics
setlocal conceallevel=2
