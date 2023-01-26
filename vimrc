set nocp
" set rtp+=/path/to/rtp/that/included/pathogen/vim " if needed
call pathogen#infect()
syntax on
filetype plugin indent on

let mapleader = ","
let maplocalleader = "\\"
set noerrorbells visualbell t_vb= " 사운드 벨, 비주얼 벨 비활성화
set nu
set ts=2 sw=2

" fzf install. this plugin were installed with homebrew
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :Files<Cr>
" :cp로 작업 디렉토리 바꿀 수 있다. TODO :Files <디렉터리명>을 단축키로 만들기

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

"1번 위키(공개용)와 2번 위키(개인용).
"TODO 공개용 위키 저장소 생성 및 로컬에 다운로드 후 path 설정 변경하기
let g:vimwiki_list = [
			\{
			\   'path': '~/study/wiki',
			\   'ext' : '.md',
			\   'diary_rel_path': '.',
			\},
			\{
			\   'path': '~/local-wiki',
			\   'ext' : '.md',
			\   'diary_rel_path': '.',
			\},
			\]

" vimwiki의 conceallevel 을 끄는 쪽이 좋다
let g:vimwiki_conceallevel = 0
let g:vimwiki_autowriteall = 1
let g:md_modify_disabled = 0

" g:vimwiki_list 경로에 있지 않은 *.md 파일을 모두 vimwiki 형식으로 인식
" markdown 파일용 custom vim 설정(ftplugin, ultisnip 등등)이 모두 작동하지 않을 경우
" let g:vimwiki_global_ext = 0

" 자주 사용하는 vimwiki 명령어 단축키 설정
command! WikiIndex :VimwikiIndex
nmap <LocalLeader>ww <Plug>VimwikiIndex
nmap <LocalLeader>wi <Plug>VimwikiDiaryIndex
nmap <LocalLeader>w<LocalLeader>w <Plug>VimwikiMakeDiaryNote
nmap <LocalLeader>wt :VimwikiTable<CR>
nmap <LocalLeader>wd :VimwikiDeleteFile<CR>


" F4 키를 누르면 커서가 놓인 단어를 위키에서 검색한다.
nnoremap <F4> :execute "VWS /" . expand("<cword>") . "/" <Bar> :lopen<CR>

" Shift F4 키를 누르면 현재 문서를 링크한 모든 문서를 검색한다
nnoremap <S-F4> :execute "VWB" <Bar> :lopen<CR>

" 메타데이터의 updated 항목 자동 업데이트
function! LastModified()
	if g:md_modify_disabled
		return
	endif

	if (&filetype != "vimwiki")
		return
	endif

	if &modified
		" echo('markdown updated time modified')
		let save_cursor = getpos(".")
		let n = min([10, line("$")])

		exe 'keepjumps 1,' . n . 's#^\(.\{,10}updated\s*: \).*#\1' .
					\ strftime('%Y-%m-%d %H:%M:%S +0900') . '#e'
		call histdel('search', -1)
		call setpos('.', save_cursor)
	endif
endfun

" 메타데이터 자동 입력
function! NewTemplate()
	let l:wiki_directory = v:false

	for wiki in g:vimwiki_list
		if expand('%:p:h') . '/' =~ expand(wiki.path)
			let l:wiki_directory = v:true
			break
		endif
	endfor

	if !l:wiki_directory
		return
	endif

	if line("$") > 1
		return
	endif

	let l:template = []
	call add(l:template, '---')
	call add(l:template, 'layout  : wiki')
	call add(l:template, 'title   : ')
	call add(l:template, 'summary : ')
	call add(l:template, 'date    : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
	call add(l:template, 'updated : ' . strftime('%Y-%m-%d %H:%M:%S +0900'))
	call add(l:template, 'tags    : ')
	call add(l:template, 'toc     : true')
	call add(l:template, 'public  : true')
	call add(l:template, 'parent  : ')
	call add(l:template, 'latex   : false')
	call add(l:template, '---')
	call add(l:template, '* TOC')
	call add(l:template, '{:toc}')
	call add(l:template, '')
	call add(l:template, '# ')
	call setline(1, l:template)
	execute 'normal! G'
	execute 'normal! $'

	echom 'new wiki page has created'
endfunction

" vimwiki 도움 함수를 자동 호출 목록에 등록
augroup vimwikiauto
	autocmd BufWritePre *wiki/**/*.md keepjumps call LastModified()
	autocmd BufRead,BufNewFile *wiki/**/*.md call NewTemplate()
	autocmd BufRead,BufNewFile *wiki/*.md TagbarOpen "마크다운 편집시 자동으로 Tagbar를 연다
augroup END

" vim-airline 설정
let g:airline#extensions#tabline#enabled = 1              " vim-airline 버퍼 목록 켜기
let g:airline#extensions#tabline#fnamemod = ':t'          " vim-airline 버퍼 목록 파일명만 출력
let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer number를 보여준다
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format

nnoremap <C-S-t> :enew<Enter> " 새로운 버퍼를 연다
nnoremap <silent> <F2><F3>   :bnext!<CR>
nnoremap <silent> <F2><F1>   :bprevious!<CR>
nnoremap <silent> <F2>d      :bd!<CR>
nnoremap <silent> <F2>o      :%bd <BAR> e # <BAR> bd #<CR> " 현재 버퍼만 남기고 모두 닫는다

" startify로 세션을 다시 불러올 때마다 tagbar를 다시 부르려고 하는데, 이미
" 만들어진 tagbar가 있어서 두 버퍼가 충돌하는 것 같다. tagbar는 단축키로 켜고
" 꺼도 상관 없고 세션을 문제없이 여는 게 더 중요하다고 생각되어서 이 설정을
" 비활성화했다.
" tagbar에서 ~/.ctags.d/vimwiki.ctags 파일에서 정의한 vimwiki 언어를 인식
nnoremap <LocalLeader>b :TagbarToggle<CR>:e<CR>
" let g:tagbar_type_vimwiki = {
" 			\ 'ctagstype' : 'vimwiki',
" 			\ 'sort': 0,
" 			\ 'kinds' : [
" 				\ 'h:Heading'
" 				\ ]
" 				\ }

" insert lozenge char with ctrl-L
imap <c-l> ◊
