set nocp
" set rtp+=/path/to/rtp/that/included/pathogen/vim " if needed
call pathogen#infect()
syntax on
colo onedark
filetype plugin indent on
runtime macros/matchit.vim

let mapleader = ","
let maplocalleader = "\\"

nnoremap <leader>vec :vsplit ~/.vim/vimrc <BAR> wincmd L <CR>
nnoremap <leader>vsc :up ~/.vim/vimrc <BAR> :source ~/.vim/vimrc <CR>

function! CapitalizeSqlFunctionName() range
    silent! execute ":'<,'>s/\\v(<ascii)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<char>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<concat>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<varchar>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<text>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<values>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<length>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<position>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<locate>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<strcmp>)/\\U\\1/g"
endfunction
function! CapitalizeSqlKeyword() range
    silent! execute ":'<,'>s/\\v(<show warnings>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<create table>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<insert into>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<delete>)/\\U\\1/g"

    silent! execute ":'<,'>s/\\v(<update>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<set>)/\\U\\1/g"

    silent! execute ":'<,'>s/select/SELECT/g"
    silent! execute ":'<,'>s/from/FROM/g"
    silent! execute ":'<,'>s/order by/ORDER BY/g"
    silent! execute ":'<,'>s/where/WHERE/g"
    silent! execute ":'<,'>s/having/HAVING/g"
    silent! execute ":'<,'>s/group by/GROUP BY/g"
    silent! execute ":'<,'>s/distinct/DISTINCT/g"
    silent! execute ":'<,'>s/\\v(<or>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<is null>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<on>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<not>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<in>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<like>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<and>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<between>)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<regexp)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<union)/\\U\\1/g"
    silent! execute ":'<,'>s/\\v(<union all)/\\U\\1/g"
    silent! execute ":'<,'>s/inner join/INNER JOIN/g"
endfunction

function! RunAllSqlFunctions() range
    call CapitalizeSqlKeyword()
    call CapitalizeSqlFunctionName()
endfunction

autocmd Filetype sql vnoremap <leader>- :<C-u>call RunAllSqlFunctions()<CR>

autocmd FileType javascript nnoremap <leader>vsc :up ~/.vim/vimrc
			\ <BAR> :source ~/.vim/vimrc<CR>
			\ <BAR> :set ft=javascript<CR>
autocmd FileType javascript nnoremap <leader>jr :wall <BAR> :!npm run test<CR>
autocmd FileType javascript nnoremap <leader>ju :wall <BAR> :!npm run test:underscore<CR>
autocmd FileType javascript nnoremap <leader>c Iconsole.log(<C-o>A);<esc>
autocmd FileType javascript nnoremap <leader>uc V:s/console.log(\(.*\));/\1/<cr>
autocmd FileType javascript inoremap {<CR> {<CR>}<C-o>O
autocmd FileType javascript inoremap (<CR> (<CR>)<C-o>O
autocmd FileType javascript nnoremap <leader>jfa 0f[V:s/ /, /g<cr>
autocmd FileType javascript nnoremap <leader>jcd odescribe('', function () {<C-o>o});<esc>kf'a
autocmd FileType javascript nnoremap <leader>jci oit('', function () {<C-o>o});<esc>kf'a
autocmd FileType javascript vnoremap <C-c> :normal 0i//<esc>
autocmd FileType javascript vnoremap <C-u> :normal 0xx<esc>
autocmd FileType javascript nnoremap <leader>h
			\ :echo ",vec\tedit vimrc\n"
			\ . ",vsc\tupdate vimrc\n"
			\ . ",jr\trun javascript\n"
			\ . ",c\twrap with console.log();\n"
			\ . ",c\tunwrap console.log();\n"
			\ . "{\<CR\>\tautocomplete closing bracket"
			\ . ",jfa\ts/ /,/g\n"
			\ . ",jcd\tsetup describe()\n"
			\ . ",jci\tsetup it()\n"
			\ <CR>

autocmd FileType ruby nnoremap <leader>vsc :up ~/.vim/vimrc
			\ <BAR> :source ~/.vim/vimrc<CR>
			\ <BAR> :set ft=ruby<CR>
autocmd FileType ruby nnoremap <leader>rsp :wall <BAR> :!rspec % <CR>
autocmd FileType ruby nnoremap <leader>rb :wall <BAR> :!ruby % <CR>
autocmd FileType ruby nnoremap <leader>rr :up <BAR> :!rake install <CR>


nnoremap <F8> :G log <BAR> wincmd L <BAR> wincmd h <CR>

" For korean encoding
set encoding=utf-8
set fileencodings=utf-8,cp949

set nu
set ts=2 sw=2

" save folding and reroad automatically
au BufWinLeave *.wofl mkview
au BufWinEnter *.wofl silent loadview

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
