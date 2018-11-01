if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

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

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
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
set pastetoggle=<F9>
nmap <C-L> :MarkClear<CR>:noh<CR>
nmap gr gT

call plug#begin('~/.vim/plugged')
"Plug 'lvht/phpcd.vim',{'for':'php'}            "php类成员和函数补全
Plug 'scrooloose/nerdtree'                     "目录树
Plug 'scrooloose/nerdcommenter'                "注释补全
Plug 'ctrlpvim/ctrlp.vim'                      "快速查找文件
Plug 'ervandew/supertab'                       "tab 键补全
Plug 'majutsushi/tagbar'                       "显示本文件函数
Plug 'bronson/vim-trailing-whitespace'         "显示行尾空格
Plug 'junegunn/vim-easy-align'                 "根据符号对齐
Plug 'https://github.com/GenialX/phpcheck.git' "php语法检查
Plug 'fatih/vim-go'                            "vimgo
Plug 'mattn/emmet-vim'                         "<>标签
Plug 'Yggdroot/vim-mark'                       "<leader>m 高亮
Plug 'brooth/far.vim'                          "快速找字符串 F xx **
Plug 'posva/vim-vue'                           "vim
Plug 'Rip-Rip/clang_complete'                  "c的补全
"Plug 'w0rp/ale'                                "各种语法检查和补全
"Plug 'vim-scripts/AutoComplPop'
Plug 'KeitaNakamura/neodark.vim'
call plug#end()

"map <c-e> :ALEDetail<cr>

"clang_complete
let g:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
let g:clang_complete_macros=1 "补全宏
"let g:clang_snippets=1
"set path=.,/usr/include,~/Downloads/nginx/src/,,
"set path=.,/usr/include,,
"let g:clang_complete_copen=1
" .clang_complete 定义自定义引用的头文件

"colorscheme gruvbox
colorscheme neodark
let g:neodark#terminal_transparent = 1
hi Normal ctermfg=252 ctermbg=none

"vim-go
"let g:go_get_update = 0
"let g:go_highlight_operators = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_gocode_propose_source = 0
let g:go_gocode_autobuild = 1
let g:go_fmt_command = "goimports"

"let g:go_highlight_variable_declarations = 1
"let g:go_highlight_variable_assignments = 1

" nerdtree
nmap <F2> :NERDTreeToggle<CR>

"tagbar  修改~/.vim/bundle/tagbar/autoload/tagbar/types/ctags.vim
nmap <F3> :TagbarToggle<CR>
let g:tagbar_expand = 1
let g:tagbar_autofocus = 1
let g:tagbar_silent = 1
" 显示的类型，可参考 ~/.vim/bundle/tagbar/autoload/tagbar/types/ctags.vim 增添
let g:tagbar_type_php = {
   \'ctagstype': 'php',
   \'kinds':[
        \ 'f:function',
        \ 'd:constant definitions',
   \]
\}

"注释插件
let mapleader = ","
" count,cc 光标以下count行添加注释
" count,cu 光标以下count行取消注释
" count,c空格 注释/反注释

"行尾空格
map <leader><space> :FixWhitespace<cr>

" ctrlp 忽略文件夹
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/]vendor$',
\}

" phpcheck
" let g:PHP_SYNTAX_CHECK_BIN =

" supertab 和 phpcd补全的配置
" phpcd 需要pcntl拓展 和 .phpcd.vim在根目录下指定类自动加载文件
" let g:phpcd_autoload_path =
" 通常是使用spl_autoload_register函数
let g:SuperTabRetainCompletionType=0
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCrMapping = 1
let g:SuperTabRetainCompletionDuration = 'completion'
let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1
"let g:SuperTabMappingTabLiteral = 0

function! MyTagContext()
    let str = getline('.')
    let line = col('.') . 'c'
    if str =~ '[''"][a-zA-Z0-9]*\%' . line
        return "\<c-p>"
    elseif str =~ '[0-9]\+\%' . line
        return "\<c-p>"
	endif
endfunction

let g:SuperTabCompletionContexts = ['MyTagContext', 's:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]

"autocmd FileType php
    "\ call SuperTabChain(&omnifunc, "<c-p>") |
    "\ set omnifunc=phpcd#CompletePHP |
    "\ call SuperTabSetDefaultCompletionType("<c-x><c-u>")

" 等号对齐
xmap ga <Plug>(EasyAlign)
