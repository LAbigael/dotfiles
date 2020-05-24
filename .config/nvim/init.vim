syntax on
set noerrorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>
set expandtab
set hidden
set nu
set relativenumber
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set timeoutlen=1000 ttimeoutlen=0

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

call plug#begin(stdpath('data') . '/plugged')

  " Intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'honza/vim-snippets'

  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Project navigation
  Plug 'lyuts/vim-rtags'
  Plug 'tpope/vim-fugitive'
  "
  " Languages support
  Plug 'leafgarland/typescript-vim'
  Plug 'othree/yajs.vim'
  Plug 'mxw/vim-jsx'
  Plug 'mattn/emmet-vim'

  " Themes
  Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.7' }

  " Status-line
  Plug 'itchyny/lightline.vim'

  Plug 'mbbill/undotree'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-commentary'

call plug#end()

colorscheme jellybeans

" Status-line
set noshowmode

let g:lightline = {  'colorscheme': 'jellybeans',  'mode_map': {  'n' : '<N>',  'i' : '<I>',  'R' : '<R>',  'v' : '<V>',  'V' : '<VL>',  "<C-v>": '<VB>',  'c' : '<C>',  's' : '<S>',  'S' : '<SL>',  "\<C-s>": '<SB>',  't': '<T>',  },  }

" Key mapping
let mapleader = " "

nnoremap <leader><leader> :GFiles <CR>
nnoremap <leader>, :Buffers <CR>
nnoremap <leader>. :e . <CR>

" Files related
nnoremap <leader>ff :Files <CR>
nnoremap <leader>fp :e ~/.config/nvim/ <CR>
nnoremap <leader>fS :source % <CR>
nnoremap <leader>fu :UndotreeToggle <CR>
nnoremap <leader>ss :Lines <CR>

nnoremap <buffer> <leader>mr :CocRestart<CR>

" Buffers related
nnoremap <leader>bk :bd<CR>
nnoremap <leader>br :redraw<CR>

" Remove all console.log()
nnoremap  <leader>cp :g/console\.log/d<CR>

" Windows management
nnoremap <leader>wl :wincmd l<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wv :wincmd v<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wm :only<CR>
nnoremap <leader>wq :wincmd q<CR>

" Git magic
nmap <leader>gg :G<CR>

" FORMATTERS
nnoremap <leader>bf :CocCommand prettier.formatFile <CR>

" Coc settings

" Symbol renaming.
nmap <leader>cR <plug>(coc-rename)

imap <C-l> <Plug>(coc-snippets-expand)

" GoTo code navigation.
nmap <leader>cd <Plug>(coc-definition)
nmap <buffer> <leader>cy <Plug>(coc-type-definition)
nmap <buffer> <leader>ci <Plug>(coc-implementation)
nmap <buffer> <leader>cr <Plug>(coc-references)
nnoremap <buffer> <leader>mR :CocRestart <CR>

hi default CocUnderline    cterm=undercurl
hi CocErrorSign  ctermfg=Red
hi CocWarningSign  ctermfg=Yellow
hi CocInfoSign  ctermfg=LightGreen
hi CocHintSign  ctermfg=LightBlue


function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction


