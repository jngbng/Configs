set nocp
set hi=256
set lz									" 메크로 실행중 화면을 다시 그리지 않음
set nu
set ts=2
set sts=2
set expandtab						"retab
set shiftwidth=2
set incsearch
set ai
set si
set cindent
set wildmenu
set wildmode=longest,full   " First match only to the longest common string, then use full/wildmenu match
set scrolloff=4							" keep lines between the cursor and bottom/top
set ss=1										" Nice sidescroll
set siso=9									" Even nicer sidescroll
set nosm										" No Smartmatch
set hlsearch
set backup
set nocompatible
"set backspace=2						"삽입모드에서 백스페이스를 계속 허용
set showcmd									"부분적 명령을 보여줌
set pastetoggle=<Ins>				"Ins키로 paste상태와 nopaste상태 전환

set enc=utf-8								" 인코딩 설정 "
set fenc=utf-8
set fencs=utf-8,cp949,cp932,euc-jp,shift-jis,big5,ucs-2le,latin1
set mouse=a

syntax on
filetype on
filetype indent on
filetype plugin on

" 마지막 편집 위치 복원 기능
au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "norm g`\"" |
			\ endif

" 팁 (tip)
" 사칙연산하기 | 'ctrl+r', '=', '3+5', '엔터' 8이 입력된다
" 아스키값구하기 | 해당 문자 커서 대고 'ga' 입력하면 하단에 표시된다.

" =======================================================================
" 확장자별 설정
" =======================================================================
au BufNewFile,BufRead *.pl set kp=perldoc\ -f					" perl -> perldoc
au BufNewFile,BufRead *.pm set kp=perldoc\ -f					" perl -> perldoc
au BufNewFile,BufRead *.tt set filetype=html					" template for html -> html
autocmd BufNewFile,BufRead *.p? compiler perl         " perl comiler 
"au! Syntax tt source $VIM/tt.vim
au FileType cpp,c setl mp=make\ %:t:r


" ======================================================================
" 폴더 설정이 되어 있는 파일을 열었을때 폴더 되어 있는 레벨을 설정한다.
" 기본값 0이고 모두 폴딩된다.
" ======================================================================
"set fdl=1

" ======================================================================
" 소스파일이 폴딩 되어 있을때 폴딩범위를 보여주는 컬럼의 수를 설정한다.
" ======================================================================
"set fdc=3

" This is for vertical indenting
set list
set listchars=tab:\|\  
" NOTE the space char after last backslash.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug-in 설정
"""'"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Use_Right_Window=1	"분할 창을 오른쪽에 배치
let Tlist_Inc_Winwidth = 0		"콘솔창에서 VIM 사용하기
let Tlist_Auto_Open =0			"vi 실행시 TagList 자동 실행


" OmniCppComplete plugin settings
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 0
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 0
let OmniCpp_ShowAccess = 1
let OmniCpp_DefaultNamespaces = []
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 0
let OmniCpp_SelectFirstItem = 0
let OmniCpp_LocalSearchDecl = 0

let g:acp_enableAtStartup = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for numpad
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <Esc>Oq 1
inoremap <Esc>Or 2
inoremap <Esc>Os 3
inoremap <Esc>Ot 4
inoremap <Esc>Ou 5
inoremap <Esc>Ov 6
inoremap <Esc>Ow 7
inoremap <Esc>Ox 8
inoremap <Esc>Oy 9
inoremap <Esc>Op 0
inoremap <Esc>On .
inoremap <Esc>OQ /
inoremap <Esc>OR *
inoremap <Esc>Ol +
inoremap <Esc>OS -

inoremap <silent> <C-k> <Esc>ld$a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 단축키 설정
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 태그리스트 업데이트
"nnoremap <silent> <F7> :TlistUpdate<CR>
" 태그리스트 토글
"nnoremap <silent> <F8> :Tlist<CR> 
" 현재 커서의 태그리스트 출력
"nnoremap <silent> <F9> :TlistSync<CR>

map <F2> :tabnew<CR>
nnoremap <silent> <F3> :BufExplorer<CR>
nnoremap <silent> <F4> :NERDTreeToggle<CR>

"F6은 파일 비교하기, Ctrl+F6로 파일 비교하기 해제 "
map <F6> :diffthis<CR><C-w><C-w>:diffthis<CR>
map <C-F6> :diffoff<CR><C-w><C-w>:diffoff<CR>

" F7은 Hex 모드 "
map <F7> :%!xxd<CR>
map <C-F7> :%!xxd -r<CR>

" F8은 ctags 생성 "
map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
map <F12> :!perl %<CR>

nmap \sh	:vnew \| ConqueTerm bash<CR>
nmap \o		:NERDTree<CR>

" Ctrl+k는 폴딩 접기, Ctrl+j로 폴딩 열기 "
map <C-k> v]}zf<CR>
map <C-j> zo<CR>

"F2 탭 열기.  Ctrl+h,l로 이동
map <C-h> gT
map <C-l> gt

"vnoremap <C-Insert> "+y
"map <S-Insert> "+gP

" Ctrl + a  모두 클립보드로 복사
map <C-a> mzggVG"+y`z

" Ctrl + 위, 아래 화면 스크롤
map [1;5A <C-y>
map [1;5B <C-e>

" 전체 자동 들여쓰기
nmap == mmggVG=`m




" ===========================================================
" Abbreviations
" ===========================================================
ia #i #include
ia #d #define

