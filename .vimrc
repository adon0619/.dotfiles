
" 文字コード設定
set encoding=utf-8
scriptencoding utf-8

" 行番号
set number

" 行強調表示
set cursorline

" カラースキーマ設定
syntax on
colorscheme murphy

" 行末空白ハイライト
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" インデント・タブ・スペース
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4



