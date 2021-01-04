if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

"using python

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=256
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" 以下为个人设置
set expandtab "tab转化为空格
set ts=4 " tab空格数
set sw=4 " 缩进宽度
set nocompatible
set nu "显示行数
set completeopt-=preview "关闭补全时的窗口
set ai
set cindent
set ignorecase
set pastetoggle=<F1>
set updatetime=200
nmap <silent> <C-L> :MarkClear<CR>:noh<CR>
nmap <silent> gr gT
nmap <silent> qq :pclose<CR>
"imap <F1> <C-R>=strftime("%Y-%m-%d %H:%I:%M")<CR>
"nmap <F1> i<C-R>=strftime("%Y-%m-%d %H:%I:%M")<CR><Esc>
" 上/下 移行
nmap el  :<c-u>execute 'move -1-'. v:count1<cr>
nmap dl  :<c-u>execute 'move +'. v:count1<cr>
" 分屏
nmap fp <c-w>v

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'                                        " 目录树
Plug 'scrooloose/nerdcommenter'                                   " 注释补全
Plug 'majutsushi/tagbar'                                          " 显示本文件函数
Plug 'bronson/vim-trailing-whitespace'                            " 显示行尾空格
Plug 'junegunn/vim-easy-align'                                    " 根据符号对齐
Plug 'fatih/vim-go'                                               " vimgo
Plug 'mattn/emmet-vim'                                            " <>标签
Plug 'Yggdroot/vim-mark'                                          " <leader>m 高亮
Plug 'KeitaNakamura/neodark.vim'                                  " mac上使用该主题
Plug 'airblade/vim-rooter'                                        " 根目录
Plug 'neoclide/coc.nvim', {'branch': 'release'}                   " 拓展安装在 ~/.config
Plug 'fannheyward/coc-sql', {'do': 'yarn install'}                " sql
Plug 'neoclide/coc-yaml', {'do': 'yarn install'}                  " yml
"Plug 'neoclide/coc-java', {'do': 'yarn install'}                 " java 补全
Plug 'neoclide/coc-python', {'do': 'yarn install'}                " python need   pip install jedi
Plug 'tpope/vim-fugitive'                                         " git
Plug 'dyng/ctrlsf.vim'                                            " 全局字符搜索
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }                 " 文件搜索
call plug#end()


colorscheme neodark
let g:neodark#terminal_transparent = 1
let g:NERDTreeNodeDelimiter = "\u00a0"
hi Normal ctermfg=252 ctermbg=none

"vim-go
":GoUpdateBinaries
":GoInstallBinaries
let g:go_metalinter_autosave=0
"let g:go_mod_fmt_autosave = 0
"let g:go_fmt_autosave = 0
"let g:go_fmt_autoclose = 0
let g:go_imports_autosave = 1
let g:go_get_update = 0
let g:go_template_autocreate = 0
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_echo_go_info = 0
"let g:go_def_mode='gopls'

" 自动填充struct
nmap gfs :GoFillStruct<CR>
" go rename
nmap gnm :GoRename
" go switch to _test.go
nmap gst :GoAlternate<CR>

" nerdtree
"nmap <F2> :NERDTreeToggle<CR>
nmap <F2> :NERDTreeMirror<CR>
nmap <F2> :NERDTreeToggle<CR>
nmap fn :NERDTreeFind<CR>
let NERDTreeIgnore=['\.pyc$']
"autocmd BufWinEnter * silent NERDTreeMirror

" tagbar  修改~/.vim/bundle/tagbar/autoload/tagbar/types/ctags.vim
nmap <F3> :TagbarToggle<CR>
let g:tagbar_expand = 1
let g:tagbar_autofocus = 1
let g:tagbar_silent = 1

" git plug
nmap gb :Git blame<CR>


"注释插件
let mapleader = ","
" 选中 <leader>c<space>
" count,cc 光标以下count行添加注释
" count,cu 光标以下count行取消注释
" count,c空格 注释/反注释

" 行尾空格
map <leader><space> :FixWhitespace<cr>

" leaderF
let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg','vendor'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
\}
let g:Lf_UseVersionControlTool = 0

" 对齐
xmap ga <Plug>(EasyAlign)

" coc.nvim
" CocConfig CocInstall CocList
nmap <silent> sn <Plug>(coc-diagnostic-next)
nmap <silent> sm <Plug>(coc-diagnostic-prev)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gc <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gi :CocAction java.action.organizeImports<CR>

" 检查上前一个位置是否为空格
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" tab键进行多次映射
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ctrlsf
" C-J C-K 切换匹配项目
" 依赖ack/ag
nmap <C-F> <Plug>CtrlSFPrompt
"nnoremap <C-F>t :CtrlSFToggle<CR>

let g:ctrlsf_auto_preview = 1
let g:ctrlsf_position='bottom'
let g:ctrlsf_auto_focus = {
    \ "at" : "start",
    \ "duration_less_than": 1000
    \ }
let g:ctrlsf_search_mode = 'async'

autocmd FileType python setlocal shiftwidth=0 tabstop=4 noexpandtab

let g:floaterm_keymap_toggle = '<F10>'
let g:floaterm_type = 'normal'

" author注释
nmap <F4> ms:call AddAuthor()<cr>'S
imap <F1> "git.garena.com/shopee/bg-logistics/logistics/logistics-line-site-system"
function AddAuthor()
    let n=1
    while n < 11
        let line = getline(n)
        if line=~'[#]*\s*\*\s*\S*Last\s*modified\s*:\s*\S*.*$'
        call UpdateTitle()
        return
    endif
    let n = n + 1
    endwhile
    if &filetype == 'python'
        call AddTitleForPython()
    else
        call AddTitleForC()
    endif

endfunction

"" 表示非.sh或.py结尾的文件添加此函数注释
function AddTitleForC()
    call append(0,"# -*- coding: utf-8 -*-")
    call append(1,"# author: lening.zeng@shopee.com")
    "call append(2,"# * Create time   : ".strftime("%Y-%m-%d %H:%M"))
endfunction

"" 表示.py添加此函数注释
function AddTitleForPython()
    call append(0,"# -*- coding: utf-8 -*-")
    call append(1,"# author: lening.zeng@shopee.com")
endfunction

"let g:ackprg = 'ag --nogroup --column'
let g:Lf_ShortcutF = '<C-P>'
