set nocp
" set rtp+=/path/to/rtp/that/included/pathogen/vim " if needed
call pathogen#infect()
syntax on
filetype plugin indent on

set nu
set ts=2 sw=4

" startify setup
let g:startify_session_delete_buffers = 1 "buffer 이름 충돌을 해결하나?
let g:startify_session_persistence = 0
let g:startify_bookmarks = [
			"\ { 'wiki' : '		~/study/wiki' },
			"\ { 'local-wiki' : '		~/local-wiki' },
			"\ { 'spring-core' : '		~/study/core' },
			"\ { 'toby-spring' : '		~/study/tobyspring' },
			"\ { 'algorithm-study' : '		~/study/algorithm-study' },
			"\ { 'project' : '		~/study/sool-dam-a' },
			"\ { 'project-wiki' : '		~/study/sool-dam-a.wiki' },
			\]

let g:startify_list_order = [
            \ ['    Sessions'],
            \'sessions',
            \ ['    Most Recently Used files'],
            \'files',
            \'bookmarks',
            \ ['    Commands'],
            \'commands'
            \]


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

if has('mac') && filereadable('/usr/local/lib/libInputSourceSwitcher.dylib')
		autocmd InsertLeave * call libcall('/usr/local/lib/libInputSourceSwitcher.dylib', 'Xkb_Switch_setXkbLayout', 'com.apple.keylayout.US')
endif
