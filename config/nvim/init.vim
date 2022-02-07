""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin(stdpath('data') . '/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'lfilho/cosco.vim'
Plug 'mattn/emmet-vim'
Plug 'godlygeek/tabular'
Plug 'kevineato/tagbar'
Plug 'wellle/targets.vim'
Plug 'SirVer/ultisnips'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/vim-peekaboo'
Plug 'reconquest/vim-pythonx'
Plug 'tpope/vim-repeat'
Plug 'kevineato/vim-protodef'
Plug 'kana/vim-textobj-user'
Plug 'kevineato/tinykeymap_vim'
Plug 'preservim/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'ellisonleao/glow.nvim'

Plug 'kevineato/DoxygenToolkit.vim'
Plug 'justinmk/vim-dirvish'
Plug 'terryma/vim-multiple-cursors'
Plug 'kevineato/vim-sandwich'
Plug 'kevineato/vim-signature'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'sainnhe/gruvbox-material'
Plug 'phaazon/hop.nvim'
Plug 'mbbill/undotree'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'sbdchd/neoformat'
Plug 'simrat39/symbols-outline.nvim'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on

set autoindent
set autoread
set background=dark
set backspace=indent,eol,start
set belloff=all
set breakindent
set breakindentopt=sbr,list:-1
set clipboard=unnamed,unnamedplus
set cmdheight=2
set colorcolumn=80
set complete-=i
set completeopt=menuone,preview,noinsert,noselect
set cursorline
set display=lastline
set encoding=utf-8
set expandtab
set fileencoding=utf-8
set fileencodings=utf-8
set formatoptions+=j
set grepprg=rg\ --vimgrep
set helpheight=9999
set hidden
set history=10000
set ignorecase
set inccommand=split
set matchpairs+=<:>
set mouse=a
set nohlsearch
set noshowmode
set nosmarttab
set number
set relativenumber
set ruler
set shiftwidth=4
set shortmess+=c
let &showbreak = ' '
set signcolumn=yes
set smartcase
set t_Co=256
set t_ut=
set tabstop=4
set termguicolors
set timeoutlen=300
set updatetime=50
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildmode=longest:full,full
syntax enable

if has('persistent_undo')
    set undodir=$XDG_DATA_HOME/nvim/.undo
    set undofile
endif

let g:netrw_banner = 0

let mapleader = ','

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gruvbox/gruvbox-material
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_current_word = 'underline'
let g:gruvbox_material_visual = 'grey background'
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
colorscheme gruvbox-material

highlight! link ColorColumn CursorLine

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto-pairs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup myautopairs
    autocmd!
    autocmd FileType c,cpp,h,hpp,java,snippets let b:AutoPairs = AutoPairsDefine({'\w\zs<': '>'})
    autocmd FileType rust let b:AutoPairs = AutoPairsDefine({'\w\zs<': '>'}, ["'"])
    autocmd FileType TelescopePrompt let b:autopairs_enabled = 0
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cosco.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup mycosco
    autocmd!
    autocmd FileType c,cpp,h,hpp,java imap <silent> <Leader>; <C-o><Plug>(cosco-commaOrSemiColon)
    autocmd FileType c,cpp,h,hpp,java nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DoxygenToolkit.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:DoxygenToolkit_briefTag_pre = ""

function! s:shortDoxy()
    let l:original_startCommentTag = g:DoxygenToolkit_startCommentTag
    let l:original_interCommentTag = g:DoxygenToolkit_interCommentTag
    let l:original_endCommentTag = g:DoxygenToolkit_endCommentTag
    let l:original_startCommentBlock = g:DoxygenToolkit_startCommentBlock
    let l:original_interCommentBlock = g:DoxygenToolkit_interCommentBlock
    let l:original_endCommentBlock = g:DoxygenToolkit_endCommentBlock

    let g:DoxygenToolkit_startCommentTag = "/// "
    let g:DoxygenToolkit_interCommentTag = "/// "
    let g:DoxygenToolkit_endCommentTag = ""
    let g:DoxygenToolkit_startCommentBlock = "// "
    let g:DoxygenToolkit_interCommentBlock = "// "
    let g:DoxygenToolkit_endCommentBlock = ""

    execute "Dox"

    let g:DoxygenToolkit_startCommentTag = l:original_startCommentTag
    let g:DoxygenToolkit_interCommentTag = l:original_interCommentTag
    let g:DoxygenToolkit_endCommentTag = l:original_endCommentTag
    let g:DoxygenToolkit_startCommentBlock = l:original_startCommentBlock
    let g:DoxygenToolkit_interCommentBlock = l:original_interCommentBlock
    let g:DoxygenToolkit_endCommentBlock = l:original_endCommentBlock
endfunction

nnoremap <silent> <Leader>ad <Cmd>Dox<CR>@todo description<Esc>v?@<CR><C-g>
nnoremap <silent> <Leader>as <Cmd>call <SID>shortDoxy()<CR>@todo description<Esc>v?@<CR><C-g>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" hop.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua require("hop").setup{char2_fallback_key = "<CR>"}

nnoremap <Leader>ll <Cmd>HopLineStart<CR>
nnoremap <Leader>s <Cmd>HopPattern<CR>
nnoremap <Leader>w <Cmd>HopWord<CR>
nnoremap <Leader>z <Cmd>HopChar2<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
            \   'active': {
                \     'left': [['mode', 'paste'],
                \       ['readonly', 'relativepath', 'modified']]
                \   },
                \   'colorscheme': 'gruvbox_material'
                \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:NERDCustomDelimiters = {
            \   'json': { 'left': '//' }
            \ }
let g:NERDSpaceDelims = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim-treesitter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require("nvim-treesitter.configs").setup {
    highlight = {enable = true},
    incremental_selection = {enable = true},
    textobjects = {enable = true}
}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabular
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:align_comment()
    let l:save_pos = getpos('.')[1:2]
    let l:tab_intro = "call Tabularize('/.*\\*/l1')"
    let l:tab_param = "call Tabularize('/.*@t\\?param\\%(\\[.*]\\)\\? \\+\\zs\\w\\+"
    let l:tab_ret = "call Tabularize('/.*@returns\\?\\zs \\|\\*\\zs \\?/l0')"

    if getline('.') =~# '\s*\/\*\*'
        let l:c_begin = getpos('.')[1]
    else
        let l:c_begin = search('\/\*\*', 'bcn')
    endif

    if getline('.') =~# '\s*\*\+/'
        let l:c_end = getpos('.')[1]
    else
        let l:c_end = search('\*\/', 'cn')
    endif

    let l:prev_text = getline(l:c_begin, l:c_end)
    let l:curr_text = ['']

    while l:curr_text != l:prev_text

        let l:prev_text = getline(l:c_begin, l:c_end)

        if l:c_begin + 1 != l:c_end - 1
            execute (l:c_begin + 1) . ',' . (l:c_end - 1) . l:tab_intro
        endif
        call cursor(l:c_begin, l:save_pos[1])
        if search('@t\?param', '', l:c_end)
            let l:p_begin = line('.')
            while search('@t\?param', '', l:c_end)
            endwhile
            if search('@return', '', l:c_end)
                let l:p_end = line('.') - 1
            else
                let l:p_end = l:c_end - 1
            endif
            let l:p_tail = "/l1l2')"
            if l:p_begin == l:p_end
                execute l:p_begin . ',' . l:p_end . l:tab_param . l:p_tail
            else
                execute l:p_begin . ',' . l:p_end . l:tab_param . "\\|\\*\\zs \\?" . l:p_tail
            endif
        endif
        if search('@return', 'c', l:c_end)
            let l:r_begin = line('.')
            if l:r_begin != l:c_end - 1
                execute l:r_begin . ',' . (l:c_end - 1) . l:tab_ret
            endif
        endif

        silent execute "normal v\<Plug>(textobj-comment-multiline-a)"
        " silent execute "normal \<Plug>(coc-format-selected)"
        silent execute "NeoFormat"
        sleep 100m

        call cursor(l:save_pos)

        if getline('.') =~# '\s*\/\*\*'
            let l:c_begin = getpos('.')[1]
        else
            let l:c_begin = search('\/\*\*', 'bcn')
        endif

        if getline('.') =~# '\s*\*\+/'
            let l:c_end = getpos('.')[1]
        else
            let l:c_end = search('\*\/', 'cn')
        endif

        let l:curr_text = getline(l:c_begin, l:c_end)
    endwhile
endfunction

augroup mytabular
    autocmd!
    autocmd FileType c,cpp,h,hpp,java nnoremap <buffer> <Leader>ac <Cmd>call <SID>align_comment()<CR>
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_ctags_bin = $HOME . '/.local/bin/ctags'
let g:tagbar_show_linenumbers = 2
let g:tagbar_sort = 0
let g:tagbar_type_cpp = {
            \   'ctagsargs': [
                \     '-f',
                \     '-',
                \     '--format=2',
                \     '--excmd=pattern',
                \     '--extras=+Fpr',
                \     '--fields=nksSaf',
                \     '--fields-C++=+{properties}{name}{captures}{template}{specialization}',
                \     '--language-force=C++',
                \     '--sort=no',
                \     '--append=no',
                \     '--kinds-C++=hdpgetncsufmv'
                \   ]
                \ }

nnoremap <F4> <Cmd>SymbolsOutline<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tinykeymap_vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tinykeymaps_default = []
let g:tinykeymap#break_key = 113
let g:tinykeymap#conflict = 3
let g:tinykeymap#timeout = 0

if !empty(glob((has('nvim') ? stdpath('data') : '~/.vim') . '/plugged/tinykeymap_vim/plugin/tinykeymap.vim'))
    function! s:tinykeymap_multi_enter(prefix, mappings)
        if has_key(a:mappings, 'options')
            let a:mappings['options']['name'] = a:prefix
        else
            let a:mappings['options'] = { 'name': a:prefix }
        endif
        let l:ind = 0
        for [l:key, l:val] in items(a:mappings['startmaps'])
            let l:temp = deepcopy(a:mappings['options'])
            if has_key(l:val, 'start')
                let l:temp['start'] = l:val['start']
            endif
            if has_key(l:val, 'stop')
                let l:temp['stop'] = l:val['stop']
            else
                let l:temp['stop'] = 'mode'
            endif
            if has_key(l:val, 'after')
                let l:temp['after'] = l:val['after']
            endif
            call tinykeymap#EnterMap(a:prefix . l:ind, l:key, l:temp)
            for [l:m_key, l:m_val] in items(a:mappings['maps'])
                if type(l:m_val) == v:t_string
                    call tinykeymap#Map(a:prefix . l:ind, l:m_key, l:m_val)
                elseif type(l:m_val) == v:t_dict
                    call tinykeymap#Map(a:prefix . l:ind, l:m_key, l:m_val['cmd'], l:m_val['options'])
                endif
            endfor
            let l:ind += 1
        endfor
    endfunction

    " buffers
    call s:tinykeymap_multi_enter('buffers', {
                \   'startmaps': {
                    \     '[b': {'start': 'bprevious'},
                    \     ']b': {'start': 'bnext'}
                    \   },
                    \   'maps': {
                        \     '[': '<count1>bprevious',
                        \     ']': '<count1>bnext',
                        \     'g': 'normal! gg',
                        \     'G': 'normal! G',
                        \     'd': "normal! \<C-d>zz",
                        \     'j': 'normal! gjzz',
                        \     'k': 'normal! gkzz',
                        \     'u': "normal! \<C-u>zz",
                        \     'D': 'if buflisted(0) | b # | else | bp | endif | bd #'
                        \   }
                        \ })

    " curly
    function! SearchCurly(square, curly)
        if a:square == ']'
            silent! call search('^\s*' . a:curly . ';\?$', 'esW')
        elseif a:square == '['
            silent! call search('^\s*' . a:curly . ';\?$', 'besW')
        endif
    endfunction

    call s:tinykeymap_multi_enter('curly', {
                \   'startmaps': {
                    \     '[{': {'start': 'let g:vimrc#last_curly = "{" | call SearchCurly("[", "{") | normal! zz'},
                    \     ']{': {'start': 'let g:vimrc#last_curly = "{" | call SearchCurly("]", "{") | normal! zz'},
                    \     '[}': {'start': 'let g:vimrc#last_curly = "}" | call SearchCurly("[", "}") | normal! zz'},
                    \     ']}': {'start': 'let g:vimrc#last_curly = "}" | call SearchCurly("]", "}") | normal! zz'},
                    \   },
                    \   'maps': {
                        \     '[': 'call SearchCurly("[", g:vimrc#last_curly)',
                        \     ']': 'call SearchCurly("]", g:vimrc#last_curly)'
                        \   },
                        \   'options': {
                            \     'after': 'normal! zz'
                            \   }
                            \ })

    " movement
    call tinykeymap#EnterMap('movement', '<Space>.', {'start': 'normal! zz', 'stop': 'mode', 'after': 'normal! zz'})
    call tinykeymap#Map('movement', '[', '<count1>bprevious')
    call tinykeymap#Map('movement', ']', '<count1>bnext')
    call tinykeymap#Map('movement', 'g', 'normal! gg')
    call tinykeymap#Map('movement', 'G', 'normal! G')
    call tinykeymap#Map('movement', 'd', "normal! \<C-d>")
    call tinykeymap#Map('movement', 'j', 'normal! gj')
    call tinykeymap#Map('movement', 'k', 'normal! gk')
    call tinykeymap#Map('movement', 'u', "normal! \<C-u>")

    " quickfix
    call s:tinykeymap_multi_enter('quickfix', {
                \   'startmaps': {
                    \     '[q': {'start': 'cprevious | normal! zz'},
                    \     ']q': {'start': 'cnext | normal! zz'}
                    \   },
                    \   'maps': {
                        \     '[': '<count1>cprevious',
                        \     ']': '<count1>cnext',
                        \     'c': {'cmd': 'cclose', 'options': {'exit': 1}}
                        \   },
                        \   'options': {
                            \     'after': 'normal! zz'
                            \   }
                            \ })
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsSnippetDirectories=[$HOME . '/.vim/CustomSnips']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" undotree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:undotree_HelpLine = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2

nnoremap <F5> <Cmd>UndotreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-dirvish
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:dirvish_mode = ':sort ,^.*[\/],'

highlight link DirvishSuffix LineNr

augroup mydirvish
    autocmd!
    " autocmd FileType dirvish nmap <buffer> <silent> x <Plug>(dirvish_arg):<C-u>bd <C-r>=bufnr(argv(argc() - 1))<CR><CR>
    " autocmd FileType dirvish xmap <buffer> <silent> x <Plug>(dirvish_arg):<C-u>bd <C-r>=bufnr(argv(argc() - 1))<CR><CR>
    autocmd FileType dirvish nnoremap <buffer> <silent> <Leader>bu :call <SID>make_backup('<C-r><C-f>')<CR>
    autocmd FileType dirvish nnoremap <buffer> <silent> <Leader>sb :call <SID>swap_backup('<C-r><C-f>')<CR>
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-easy-align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-multiple-cursors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-a> <Cmd>call multiple_cursors#select_all("n", 1)<CR>
xnoremap <C-a> <Cmd>call multiple_cursors#select_all("v", 0)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-sandwich
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:sandwich#magicchar#f#patterns = [
            \   {
                \     'header' : '\<\%(\h\k*\%(\.\|::\)\)*\h\k*\%(<\s\?\S*\s\?>\)\?',
                \     'bra'    : '(\s*',
                \     'ket'    : '\s*)',
                \     'footer' : ''
                \   }
                \ ]
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
            \   {'buns': ['{ ', ' }'], 'nesting': 1, 'match_syntax': 1,
            \    'kind': ['add', 'replace'], 'action': ['add'], 'input': ['}']},
            \
            \   {'buns': ['{', '}'], 'kind': ['add', 'replace'], 'action': ['add'],
            \    'motionwise': ['line'], 'command': ["'[+1,']-1normal! =="]},
            \
            \   {'buns': ['^\s*{$', '^\s*}$'], 'nesting': 1, 'regex': 1, 'linewise': 1,
            \    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
            \    'action': ['delete'], 'input': ['{{'], 'command': ["'[,']normal! =="]},
            \
            \   {'buns': ['[ ', ' ]'], 'nesting': 1, 'match_syntax': 1,
            \    'kind': ['add', 'replace'], 'action': ['add'], 'input': [']']},
            \
            \   {'buns': ['( ', ' )'], 'nesting': 1, 'match_syntax': 1,
            \    'kind': ['add', 'replace'], 'action': ['add'], 'input': [')']},
            \
            \   {'buns': ['< ', ' >'], 'nesting': 1, 'match_syntax': 1,
            \    'kind': ['add', 'replace'], 'action': ['add'], 'input': ['>']},
            \
            \   {'buns': ['{\s*', '\s*}'], 'nesting': 1, 'regex': 1,
            \    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
            \    'action': ['delete'], 'input': ['{']},
            \
            \   {'buns': ['\[\s*', '\s*\]'], 'nesting': 1, 'regex': 1,
            \    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
            \    'action': ['delete'], 'input': ['[']},
            \
            \   {'buns': ['(\s*', '\s*)'],   'nesting': 1, 'regex': 1,
            \    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
            \    'action': ['delete'], 'input': ['(']},
            \
            \   {'buns': ['<\s*', '\s*>'],   'nesting': 1, 'regex': 1,
            \    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
            \    'action': ['delete'], 'input': ['<']},
            \
            \   {'buns': ['\s\@<=\%(\k\|:\)*<\s*', '\s*>'],   'nesting': 1, 'regex': 1,
            \    'match_syntax': 1, 'kind': ['delete', 'replace', 'textobj'],
            \    'action': ['delete'], 'input': ['p']}
            \ ]
let g:textobj_sandwich_function_searchlines = 2

nmap s <Nop>
xmap s <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-signature
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:SignatureForceRemoveGlobal = 1
let g:SignatureMarkTextHLDynamic = 1
let g:SignatureMarkerTextHLDynamic = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-signify
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:signify_vcs_cmds = {
            \ 'git':      'git diff --no-color --no-ext-diff -U0 -- %f',
            \ 'yadm':     'yadm diff --no-color --no-ext-diff -U0 -- %f',
            \ 'hg':       'hg diff --color=never --config aliases.diff= --nodates -U0 -- %f',
            \ 'svn':      'svn diff --diff-cmd %d -x -U0 -- %f',
            \ 'bzr':      'bzr diff --using %d --diff-options=-U0 -- %f',
            \ 'darcs':    'darcs diff --no-pause-for-gui --no-unified --diff-opts=-U0 -- %f',
            \ 'fossil':   'fossil diff --unified -c 0 -- %f',
            \ 'cvs':      'cvs diff -U0 -- %f',
            \ 'rcs':      'rcsdiff -U0 %f 2>%n',
            \ 'accurev':  'accurev diff %f -- --color=never -U0',
            \ 'perforce': 'p4 info '. sy#util#shell_redirect('%n') . (has('win32') ? ' &&' : ' && env P4DIFF= P4COLORS=') .' p4 diff -du0 %f',
            \ 'tfs':      'tf diff -version:W -noprompt -format:Unified %f'
            \ }
let g:signify_vcs_cmds_diffmode = {
            \ 'git':      'git show HEAD:./%f',
            \ 'yadm':     'yadm show HEAD:./%f',
            \ 'hg':       'hg cat %f',
            \ 'svn':      'svn cat %f',
            \ 'bzr':      'bzr cat %f',
            \ 'darcs':    'darcs show contents -- %f',
            \ 'fossil':   'fossil cat %f',
            \ 'cvs':      'cvs up -p -- %f 2>%n',
            \ 'rcs':      'co -q -p %f',
            \ 'accurev':  'accurev cat %f',
            \ 'perforce': 'p4 print %f',
            \ 'tfs':      'tf view -version:W -noprompt %f',
            \ }

nnoremap <Leader>hd <Cmd>SignifyHunkDiff<CR>
nnoremap <Leader>hu <Cmd>SignifyHunkUndo<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-startify
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:startify_change_to_dir = 0
let g:startify_lists = [
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
            \ { 'type': 'files',     'header': ['   MRU']            },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'commands',  'header': ['   Commands']       }
            \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-textobj-user
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call textobj#user#plugin('comment', {
            \   'multiline': {
                \     'pattern': ['^\s*/\*\*', '^\s*\*\+/'],
                \     'region-type': 'V',
                \     'select-a': 'am',
                \     'select-i': 'im'
                \   }
                \ })

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions and commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:better_g_under()
    let l:col = col('.') - 1
    if getline('.')[0:l:col] =~# '^\s*$'
        return "^"
    else
        return "g_"
    endif
endfunction

function! s:better_zero()
    let l:col = col('.') - 2
    if l:col < 0 || getline('.')[0:l:col] =~# '^\s*$'
        return "0"
    else
        return "^"
    endif
endfunction

function! s:check_back_space() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1] =~# '\s'
endfunction

function! s:edit_impl(header_name, impl_name)
    edit `=a:impl_name`
    if !filereadable(a:impl_name)
        put! ='#include \"' . a:header_name . '\"'
        put =''
    endif
    execute "normal Gi\<C-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({})\<CR>"
    sleep 100m
    execute 'Format'
    normal! gg
endfunction

function! GetVisual()
    let [l:line_start, l:column_start] = getpos("'<")[1:2]
    let [l:line_end, l:column_end] = getpos("'>")[1:2]
    let l:lines = getline(l:line_start, l:line_end)
    if len(l:lines) == 0
        return ''
    endif
    let l:lines[-1] = l:lines[-1][:l:column_end - (&selection == 'inclusive' ? 1 : 2)]
    let l:lines[0] = l:lines[0][l:column_start - 1:]
    return join(l:lines, "\n")
endfunction

function! s:last_buf() abort
    if buflisted(0)
        b #
    else
        bp
    endif
endfunction

function! s:make_backup(file_name) abort
    let l:full_name = fnamemodify(a:file_name, ':p')
    let l:backup_name = l:full_name . '.bak'
    silent! execute '!cp ' . l:full_name . ' ' . l:backup_name
endfunction

function! s:swap_backup(file_name) abort
    let l:full_name = fnamemodify(a:file_name, ':p')
    let l:extension = fnamemodify(l:full_name, ':e')
    if l:extension == 'bak'
        let l:backup_name = l:full_name
        let l:normal_name = fnamemodify(l:full_name, ':r')
    else
        let l:backup_name = l:full_name . '.bak'
        let l:normal_name = l:full_name
    endif
    silent! execute '!mv ' . l:normal_name . ' ' . l:normal_name . '.bak2'
    silent! execute '!mv ' . l:backup_name . ' ' . l:normal_name
    silent! execute '!mv ' . l:normal_name . '.bak2 ' . l:backup_name
endfunction

function! s:safe_close() abort
    let l:prev_buf = bufnr()
    call s:last_buf()
    if l:prev_buf == bufnr()
        bd
    else
        bd #
    endif
endfunction

function! s:scratch(wipe_buffer, rng, start, end, ...)
    if a:wipe_buffer
        for l:win in range(1, winnr('$'))
            if getwinvar(l:win, 'scratch')
                execute l:win . 'windo close'
            endif
        endfor
    endif
    if a:0 && a:1 =~ '^!'
        let l:cmd = a:1 =~' %'
                    \ ? matchstr(substitute(a:1, ' %', ' ' . expand('%:p'), ''), '^!\zs.*')
                    \ : matchstr(a:1, '^!\zs.*')
        if a:rng == 0
            let l:output = systemlist(l:cmd)
        else
            let l:joined_lines = join(getline(a:start, a:end), '\n')
            let l:cleaned_lines = substitute(shellescape(l:joined_lines), "'\\\\''", "\\\\'", 'g')
            let l:output = systemlist(l:cmd . " <<< $" . l:cleaned_lines)
        endif
    elseif a:0
        redir => l:output
        execute a:1
        redir END
        let l:output = split(l:output, "\n")
    endif
    if a:wipe_buffer
        vnew
        let w:scratch = 1
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    else
        new +only
        setlocal buftype=nofile bufhidden=hide noswapfile
    endif
    if a:0
        call setline(1, l:output)
    endif
endfunction
command! -bang -nargs=* -complete=command -bar -range Scratch silent call <SID>scratch(<bang>0, <range>, <line1>, <line2>, <q-args>)

function! s:compareQuickfixEntries(i1, i2)
    if bufname(a:i1.bufnr) == bufname(a:i2.bufnr)
        return a:i1.lnum == a:i2.lnum ? 0 : (a:i1.lnum < a:i2.lnum ? -1 : 1)
    else
        return bufname(a:i1.bufnr) < bufname(a:i2.bufnr) ? -1 : 1
    endif
endfunction

function! s:sortUniqQFList(...)
    if a:0
        let l:sorted_list = sort(getloclist(), 's:compareQuickfixEntries')
    else
        let l:sorted_list = sort(getqflist(), 's:compareQuickfixEntries')
    endif
    let l:uniqed_list = []
    let l:last = ''
    for l:item in l:sorted_list
        let l:this = bufname(l:item.bufnr) . "\t" . l:item.lnum
        if l:this !=# l:last
            call add(l:uniqed_list, l:item)
            let l:last = l:this
        endif
    endfor
    if a:0
        call setloclist(l:uniqed_list)
    else
        call setqflist(l:uniqed_list)
    endif
endfunction

function! s:ulti_expandable()
    return !(
                \ col('.') <= 1
                \ || !empty(matchstr(getline('.'), '\%' . (col('.') - 1) . 'c\s'))
                \ || empty(UltiSnips#SnippetsInCurrentScope())
                \ )
endfunction

command! EditImpl call s:edit_impl(expand('%:t'), expand('%:r') . '.cpp')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General key maps
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

cnoremap <C-h> <Home>
cnoremap <C-l> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-s> <S-Left>
cnoremap <C-d> <S-Right>
cnoremap <C-o> <Up>
cnoremap <C-k> <Down>
nnoremap <Leader><Space> <Cmd>nohlsearch<CR><Cmd>diffupdate<CR><Cmd>syntax sync fromstart<CR><Cmd>mode<CR>
nnoremap <Leader><Tab> <Cmd>call <SID>last_buf()<CR>
nnoremap <Leader>- <Cmd>split<CR>
nnoremap <Leader>/ <Cmd>vsplit<CR>
nnoremap <Leader>C <Cmd>call <SID>safe_close()<CR>
nnoremap <Leader>d "_d
xnoremap <Leader>d "_d
xnoremap <Leader>p "_dP
nnoremap <Leader>qc <Cmd>cclose<CR>zz
nnoremap <Leader>qlc <Cmd>lclose<CR>zz
nnoremap <Leader>qlr <Cmd>lclose<CR>zz<Cmd>call setloclist(0, [])<CR>
nnoremap <Leader>qln <Cmd>lnext<CR>zz
nnoremap <Leader>qlp <Cmd>lprevious<CR>zz
nnoremap <Leader>qlo <Cmd>lopen<CR><C-w>pzz
nnoremap <Leader>qls <Cmd>call <SID>sortUniqQFList(1)<CR>
nnoremap <Leader>qn <Cmd>cnext<CR>zz
nnoremap <Leader>qp <Cmd>cprevious<CR>zz
nnoremap <Leader>qo <Cmd>copen<CR><C-w>pzz
nnoremap <Leader>qr <Cmd>cclose<CR>zz<Cmd>call setqflist([])<CR>
nnoremap <Leader>qs <Cmd>call <SID>sortUniqQFList()<CR>
nnoremap <Leader>u <Cmd>up<CR>
nnoremap <Space><CR> m`o<Esc>``
nnoremap <Space><A-CR> m`O<Esc>``
nnoremap <Space>w <C-w>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap ` '
noremap ' `
noremap \ ,
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'
nnoremap <silent> <expr> 0 <SID>better_zero()
onoremap <silent> <expr> 0
            \ col('.') == len(getline('.')) ?
            \ "v" . <SID>better_zero() :
            \ <SID>better_zero()
xnoremap <silent> <expr> 0 <SID>better_zero()
nnoremap <silent> <expr> g_ <SID>better_g_under()
onoremap <silent> <expr> g_ <SID>better_g_under()
xnoremap <silent> <expr> g_ <SID>better_g_under()
map H 0
map L g_
vmap < <gv
vmap > >gv
vnoremap <silent> * :<C-U>
            \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \ gvy/<C-r>=&ic?'\c':'\C'<CR><C-r><C-r>=substitute(
            \ escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \ gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \ let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \ gvy?<C-r>=&ic?'\c':'\C'<CR><C-r><C-r>=substitute(
            \ escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \ gVzv:call setreg('"', old_reg, old_regtype)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General autocmds
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:autoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

function! s:autoRestoreWinView()
    let l:buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, l:buf)
        let l:v = winsaveview()
        let l:atStartOfFile = l:v.lnum == 1 && l:v.col == 0
        if l:atStartOfFile && !&diff
            call winrestview(w:SavedBufView[l:buf])
        endif
        unlet w:SavedBufView[l:buf]
    endif
endfunction

let g:doxygen_end_punctuation='\n\%(\s*\*\s*@param\\S*\|\s*\*\{2,}/\)\@='

lua << EOF
require("telescope").setup({
    defaults = {
        layout_strategy = "vertical"
    }
})
require("telescope").load_extension("fzy_native")
EOF

lua require("personal")

augroup myautocmd
    autocmd!
    autocmd BufEnter * call s:autoRestoreWinView()
    autocmd BufEnter *.h,*.hpp nnoremap <buffer> <Leader>PP <Cmd>EditImpl<CR>
    " autocmd BufEnter *.c,*.cpp nnoremap <buffer> <silent> <Leader>PP o<C-r>=protodef#ReturnSkeletonsFromPrototypesForCurrentBuffer({})<CR><Esc>v`[:<C-u>call CocActionAsync('formatSelected', visualmode())<CR>
    autocmd BufLeave * call s:autoSaveWinView()
    autocmd BufNewFile,BufRead .clang-format set filetype=yaml
    autocmd BufNewFile,BufReadPre *.c,*.cpp,*.h,*.hpp,*.java let b:load_doxygen_syntax=1
    autocmd BufWritePost ~/.dotfiles/config/nvim/init.vim ++nested source ~/.dotfiles/config/nvim/init.vim
    autocmd FileType c,cmake,cpp,h,hpp,java,snippets setlocal expandtab tabstop=4 shiftwidth=4
    autocmd FileType gitcommit setlocal formatoptions-=t
    autocmd FileType help nnoremap <buffer> q <Cmd>q<CR>
    autocmd FileType glowpreview,help,man nnoremap <buffer> d <C-d>
    autocmd FileType glowpreview,help,man nnoremap <buffer> u <C-u>
    autocmd FileType glowpreview,markdown setlocal linebreak
    autocmd FileType man nnoremap <buffer> <silent> q <Cmd>call <SID>safe_close()<CR><Cmd>if winnr('$') > 1 <Bar> q <Bar> endif<CR>
    autocmd FileType man wincmd _
    autocmd FileType markdown setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:
    autocmd FileType json syntax match Comment +\/\/.\+$+
    autocmd InsertEnter,WinLeave * set nocursorline
    autocmd InsertLeave,WinEnter * set cursorline
augroup end

if filereadable(stdpath('config') . '/local.vim')
    execute printf('source %s', stdpath('config') . '/local.vim')
endif
