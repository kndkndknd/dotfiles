" dein.vim {{{
"  directory configuration
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:dein_config_dir = s:config_home . '/nvim/dein'
let s:toml_file = s:dein_config_dir . '/toml/dein.toml'
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"  dein installation
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
"  path
let &runtimepath = s:dein_repo_dir . "," . &runtimepath
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif
"  install new plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" dein.vim }}}

" deoplete
" let g:deoplete#enable_at_startup=1

" 通常の設定
set autoindent
set shiftwidth=2
set smartindent
set expandtab
set incsearch
set number
set showmatch
set smarttab
set backspace=indent,eol,start
set splitright
set splitbelow
