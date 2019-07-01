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
set updatetime=200
nmap <silent> <C-L> :MarkClear<CR>:noh<CR>
nmap <silent> gr gT
nmap <silent> qq :pclose<CR>

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'                                        " 目录树
Plug 'scrooloose/nerdcommenter'                                   " 注释补全
Plug 'ctrlpvim/ctrlp.vim'                                         " 快速查找文件
Plug 'ervandew/supertab'                                          " tab 键补全
Plug 'majutsushi/tagbar'                                          " 显示本文件函数
Plug 'bronson/vim-trailing-whitespace'                            " 显示行尾空格
Plug 'junegunn/vim-easy-align'                                    " 根据符号对齐
Plug 'fatih/vim-go'                                               " vimgo
Plug 'mattn/emmet-vim'                                            " <>标签
Plug 'Yggdroot/vim-mark'                                          " <leader>m 高亮
Plug 'rking/ag.vim'                                               " 快速查找字符串
Plug 'KeitaNakamura/neodark.vim'                                  " mac上使用该主题
Plug 'airblade/vim-rooter'                                        " 根目录

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}         " 拓展安装在 ~/.config
Plug 'Maxattax97/coc-ccls', {'do': 'yarn install'} " c/c++ 补全
Plug 'neoclide/coc-python', {'do': 'yarn install'} " python 补全
Plug 'marlonfan/coc-phpls', {'do': 'yarn install'} " php 补全
"Plug 'josa42/coc-go', {'do': 'yarn install'} " go 补全
"Plug 'josa42/coc-sh', {'do': 'yarn install'}       " sh 补全
call plug#end()

colorscheme neodark
let g:neodark#terminal_transparent = 1
let g:NERDTreeNodeDelimiter = "\u00a0"
hi Normal ctermfg=252 ctermbg=none

"vim-go
":GoUpdateBinaries
":GoInstallBinaries
let g:go_metalinter_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_get_update = 0
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_chan_whitespace_error = 1
"let g:go_def_mode='gopls'

" nerdtree
nmap <F2> :NERDTreeToggle<CR>
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

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

" supertab 和 phpcd补全的配置
let g:SuperTabRetainCompletionType=0
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCrMapping = 1
let g:SuperTabRetainCompletionDuration = 'completion'
let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced = 1

function! MyTagContext()
    let str = getline('.')
    let line = col('.') . 'c'
    if str =~ '[''"$][a-zA-Z0-9]*\%' . line
        return "\<c-p>"
    elseif str =~ '[0-9]\+\%' . line
        return "\<c-p>"
    endif
endfunction

let g:SuperTabCompletionContexts = ['MyTagContext', 's:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc']
let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]

" 对齐
xmap ga <Plug>(EasyAlign)

" coc.nvim
" CocConfig CocInstall CocList
nmap <silent> sn <Plug>(coc-diagnostic-next)
nmap <silent> sm <Plug>(coc-diagnostic-prev)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> ge <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" 代码搜索
" 依赖 the_silver_searcher yum/brew 安装即可
" ag 字符串
let g:ag_working_path_mode = 'r'
let g:ag_highlight = 1
