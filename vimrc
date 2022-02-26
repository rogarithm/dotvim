set nocp
" set rtp+=/path/to/rtp/that/included/pathogen/vim " if needed
call pathogen#infect()
syntax on
filetype plugin indent on

set nu
set ts=2 sw=4

" Create an augroup if you don’t already have one
augroup configgroup
    autocmd!

    "Set Pollen syntax for files with these extensions:
    au! BufRead,BufNewFile *.pm set filetype=pollen
    au! BufRead,BufNewFile *.pp set filetype=pollen
    au! BufRead,BufNewFile *.ptree set filetype=pollen
		au! BufRead,BufNewFile *.scrbl setfiletype scribble

    " Suggested editor settings:
    autocmd FileType pollen setlocal wrap      " Soft wrap (don't affect buffer)
    autocmd FileType pollen setlocal linebreak " Wrap on word-breaks only
augroup END

" insert lozenge char with ctrl-L
imap <c-l> ◊

endif
