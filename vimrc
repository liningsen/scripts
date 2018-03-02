""=======================iTerm2=========================""
set t_Co=256
let &t_ti.="\<Esc>]1337;HighlightCursorLine=true\x7"
let &t_te.="\<Esc>]1337;HighlightCursorLine=false\x7"
""=======================iTerm2=========================""
"
""=======================COMMON=========================""
set nocompatible
set nu
set hls
set expandtab
set ts=4
set shiftwidth=4
set autoindent
" if one line is too long, it will show in multi lines
"set wrap
set nowrap
"set list
" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable
" 编码
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
set termencoding=utf-8
"set termencoding=gbk
" 显示光标当前位置
"set ruler
" 高亮显示当前行/列
"set cursorline
"set cursorcolumn
" code style
set colorcolumn=81
" fix mac vim delete error, so as set backspace=indent,eol,start
set backspace=2
" Tab navigation like Firefox.
"nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <ESC>[Z :tabprevious<CR>
"nnoremap <C-tab>   :tabnext<CR>
nnoremap <ESC>\t :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
nnoremap <ESC>[Z <Esc>:tabprevious<CR>
nnoremap <ESC>[z <Esc>:tabnext<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
"" Tab Move
nnoremap <silent> <Esc>b :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <Esc>f :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
""=======================COMMON=========================""

""======================PATHOGEN========================""
execute pathogen#infect()
filetype plugin indent on
syntax on
""======================PATHOGEN========================""

""====================COLOR_SCHEME======================""
" molokai
syntax on
let g:rehash256 = 1
colorscheme molokai
" solarized
"syntax enable
""set background=light
"set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized
""====================COLOR_SCHEME======================""

""======================TAG_LIST========================""
filetype on
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
map <silent> tl :TlistToggle<CR>
"map <silent> <leader>tl :TlistToogle<cr>
""======================TAG_LIST========================""

""=================== YOUCOMPLETEME=====================""
let g:ycm_key_invoke_completion = '<M-;>'
" immediately recompile your file and display any new diagnostics it encounters
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>yf :YcmCompleter GoToInclude<CR>
nnoremap <leader>yt :YcmCompleter GetType<CR>
nnoremap <leader>yp :YcmCompleter GetParent<CR>
nnoremap <leader>yd :YcmCompleter GetDoc<CR>
"" turn on completion in comments
let g:ycm_complete_in_comments=1
"" turn on tag completion
let g:ycm_collect_identifiers_from_tags_files=1
"" complete syntax keywords
let g:ycm_seed_identifiers_with_syntax=1
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" YCM will populate the location list automatically every time it gets new diagnostic data
"let g:ycm_always_populate_location_list = 1
function! s:CustomizeYcmLocationWindow()
  " Move the window to the top of the screen.
  wincmd K
  " Set the window height to 5.
  5wincmd _
  " Switch back to working window.
  wincmd p
endfunction
autocmd User YcmLocationOpened call s:CustomizeYcmLocationWindow()

function! s:CustomizeYcmQuickFixWindow()
  " Move the window to the top of the screen.
  wincmd K
  " Set the window height to 5.
  5wincmd _
endfunction
autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()
""=================== YOUCOMPLETEME=====================""

"""======================NERDTree========================""
map <C-n> :NERDTreeToggle<CR>
" Start NERDTree
autocmd VimEnter * NERDTree
" Go to previous (last accessed) window.
autocmd VimEnter * wincmd p
" close vim if the only window left open is a NERDTree
autocmd BufEnter * nested if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
""======================NERDTree========================""

""========================CTRLP=========================""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = 'find %s -type f' " MacOSX/Linux
""========================CTRLP=========================""

""=======================AIRLINE========================""
" used in macvim
set guifont=Noto\ Mono\ for\ Powerline:h18
let g:airline_powerline_fonts = 1
" Airline Theme
let g:airline_theme='molokai'
" Airline tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
" 是否显示实际buffer编号
let g:airline#extensions#tabline#buffer_nr_show = 0
""=======================AIRLINE========================""

""=======================TAGBAR=========================""
nmap <F8> :TagbarToggle<CR>
""=======================TAGBAR=========================""

""=====================EasyMotion=======================""
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and somtimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
" incsearch.vim x fuzzy x vim-easymotion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
""=====================EasyMotion=======================""

""==================NERDTreeCommenter===================""
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
""==================NERDTreeCommenter===================""

""======================Numbers=========================""
nnoremap <F3> :NumbersToggle<CR>
noremap <F4> :set invnumber<CR>
inoremap <F4> <C-O>:set invnumber<CR>
""======================Numbers=========================""

""=====================EasyGrep=========================""
let g:EasyGrepCommand=1 " 0 - vimgrep, 1 - grep (follows grepprg)
let g:EasyGrepFilesToExclude='*.swp,*~,.svn,.git'
"let g:EasyGrepExtraWarnings=1
""=====================EasyGrep=========================""

""======================Repeat==========================""
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
""======================Repeat==========================""
