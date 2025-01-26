call plug#begin("~/vimfiles/plugged")
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
"Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
Plug 'kurocode25/mdforvim'
Plug 'puremourning/vimspector'

"Typescript and Javascript
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'chun-yang/auto-pairs'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
"Java

call plug#end()

if has('nvim')
    " Use Alt + ; to go to normal mode
    tnoremap <A-;> <C-\><C-n>
    " Use Alt + Shift + ; to go to command mode
    tnoremap <A-:> <C-\><C-n>:
    " Open new terminals in splits
    cabbrev term <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'split term://cmd.exe' : 'term')<CR>
    cabbrev vterm <C-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'vsplit term://cmd.exe' : 'vterm')<CR>
    augroup term_cmds
        autocmd!
        " Bypass normal mode when changing focus to terminal buffer
        autocmd BufWinEnter,WinEnter term://* startinsert
        " Toggle numbers off when in terminal mode, on when in normal mode
        autocmd TermEnter term://* setlocal nonu nornu
        autocmd TermLeave term://* setlocal nu rnu
        " Immediately close terminal window when process finishes
        autocmd TermClose term://* close
    augroup END
endif



""""""""""""""""""""""""""""" Basic Settings """""""""""""""""""""""""""""
syntax on
set encoding=utf-8
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set number relativenumber
set backspace=indent,eol,start
set belloff=all
set scrolloff=5
set noeb t_vb =
set t_Co=256
set updatetime=50
set signcolumn=yes
set nocursorline
set wrap breakindent
nmap <TAB> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""" Key Schortcuts """""""""""""""""""""""""""""
inoremap <C-e> <ESC>ea
inoremap <C-b> <C-o>b
inoremap <C-a> <C-o>A
inoremap <C-s> <C-o>I
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l

nmap <leader>u :<C-U><C-R>=printf("/%s", expand("<cword>"))<CR><CR>
nmap <leader>s :w<CR>
nmap <leader>fl :Leaderf rg --popup --case-sensitive -e 
" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>

""""""""""""""""""""""""""""" Go Settings """""""""""""""""""""""""""""
filetype plugin indent on

set autowrite

" HTML, XML, CSS, SCSS
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Markdown and Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2

"Exit insert mode
inoremap ii <ESC>

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

if !has('gui_running')
	  set t_Co=256
endif
set termguicolors

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

nmap <TAB> :NERDTreeToggle <CR>
colorscheme gruvbox

""""""""""""""""""""""""""""" Coc Settings """""""""""""""""""""""""""""

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

nnoremap <silent> K :call ShowDocumentation()<CR>

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

autocmd CursorHold * silent call CocActionAsync('highlight')

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! CheckBackspace() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
                  \ coc#refresh()

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
endif

"""""""""""""""""""""""""""""LeaderF settings"""""""""""""""""""""
" Do not use cache file
let g:Lf_UseCache = 0
" Refresh each time we call leaderf
let g:Lf_UseMemoryCache = 0

" Ignore certain files and directories when searching files
let g:Lf_WildIgnore = {
  \ 'dir': ['.idea', 'node_modules', '.git', '__pycache__', '.DS_Store'],
  \ 'file': ['*.exe', '*.dll', '*.so', '*.o', '*.pyc', '*.jpg', '*.png',
  \ '*.gif', '*.svg', '*.ico', '*.db', '*.tgz', '*.tar.gz', '*.gz',
  \ '*.zip', '*.bin', '*.pptx', '*.xlsx', '*.docx', '*.pdf', '*.tmp',
  \ '*.wmv', '*.mkv', '*.mp4', '*.rmvb', '*.ttf', '*.ttc', '*.otf',
  \ '*.mp3', '*.aac']
  \}

" Only fuzzy-search files names
let g:Lf_DefaultMode = 'FullPath'
 
" Popup window settings
let w = float2nr(&columns * 0.8)
if w > 140
  let g:Lf_PopupWidth = 140
else
  let g:Lf_PopupWidth = w
endif

let g:Lf_PopupPosition = [0, float2nr((&columns - g:Lf_PopupWidth)/2)]

" Do not use version control tool to list files under a directory since
" submodules are not searched by default.
let g:Lf_UseVersionControlTool = 0

" show dot files
let g:Lf_ShowHidden = 1

" Disable default mapping
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''

" set up working directory for git repository
let g:Lf_WorkingDirectoryMode = 'a'

" Search files in popup window
nnoremap <silent> <leader>ff :<C-U>Leaderf file --popup<CR>

" Grep project files in popup window
nnoremap <silent> <leader>fg :<C-U>Leaderf rg --no-messages --popup<CR>

" Search vim help files
nnoremap <silent> <leader>fh :<C-U>Leaderf help --popup<CR>

" Search tags in current buffer
nnoremap <silent> <leader>ft :<C-U>Leaderf bufTag --popup<CR>

" Switch buffers
nnoremap <silent> <leader>fb :<C-U>Leaderf buffer --popup<CR>

" Search recent files
nnoremap <silent> <leader>fr :<C-U>Leaderf mru --popup --absolute-path<CR>

let g:Lf_PopupColorscheme = 'gruvbox_material'

" Change keybinding in LeaderF prompt mode, use ctrl-n and ctrl-p to navigate
" items.
let g:Lf_CommandMap = {'<C-J>': ['<C-N>'], '<C-K>': ['<C-P>']}

nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
nnoremap <silent><leader>$ <Cmd>BufferLineGoToBuffer -1<CR>

""""""""""""""""""""""""""""" Vimwiki """""""""""""""""""""""""""""
let g:vimwiki_list = [{'path' : 'C:\Users\berka\Documents\vimwiki', 'syntax' : 'markdown', 'ext' : '.md'}]

nnoremap <C-z> <Plug>VimwikiToggleListItem

""""""""""""""""""""""""""""" Vimspector """""""""""""""""""""""""""""
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
nmap <leader>vi <Plug>VimspectorBalloonEval
xmap <leader>vi <Plug>VimspectorBalloonEval

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]
""""""""""""""""""""""""""""" Lua Config """""""""""""""""""""""""""""
lua << EOF
require('lualine-config')
require('bufferline-config')
require('nvim-treesitter-config')
EOF
