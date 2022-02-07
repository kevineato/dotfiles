function! s:get_num_clients()
    let l:Get_num_clients = luaeval('function() for _ in pairs(vim.lsp.buf_get_clients()) do _A = _A + 1 end return _A end', 0)
    return l:Get_num_clients()
endfunction

function! s:do_format()
    if s:get_num_clients() == 0 || &filetype == 'cmake'
        execute 'Neoformat'
    else
        execute 'lua vim.lsp.buf.formatting()'
    endif
endfunction

function! s:execute_with_clients(none_keys, lua_code)
    if s:get_num_clients() == 0
        call feedkeys(a:none_keys, 'n')
    else
        execute 'lua ' . a:lua_code
    endif
endfunction

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        let l:word = expand('<cword>')
        if match(getline('.'), l:word . '(') != -1
            execute 'h ' . l:word . '()'
        elseif match(getline('.'), 'set ' . l:word) != -1 ||
                    \ match(getline('.'), "'" . l:word . "'") != -1
            execute 'h ' . "'" . l:word . "'"
        else
            execute 'h ' . l:word
        endif
    else
        lua vim.lsp.buf.hover()
    endif
endfunction

inoremap <C-k> <Cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <Space>f <Cmd>call <SID>do_format()<CR>
nnoremap <Space>k <Cmd>lua vim.diagnostic.open_float(nil, {focus = false})<CR>
nnoremap <Space>rn <Cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <Space>a <Cmd>lua require("telescope.builtin").lsp_code_actions()<CR>
xnoremap <Space>a <Cmd>lua require("telescope.builtin").lsp_range_code_actions()<CR>
nnoremap <Space>d <Cmd>call <SID>execute_with_clients('gd', 'require("telescope.builtin").lsp_definitions()')<CR>
nnoremap <Space>e <Cmd>lua require("telescope.builtin").diagnostics()<CR>
nnoremap <Space>i <Cmd>lua require("telescope.builtin").lsp_implementations()<CR>
nnoremap <Space>r <Cmd>lua require("telescope.builtin").lsp_references()<CR>
nnoremap <Space>sa <Cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>
nnoremap <Space>sd <Cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>
nnoremap <Space>sw <Cmd>lua require("telescope.builtin").lsp_workspace_symbols()<CR>
nnoremap <Space>t <Cmd>lua require("telescope.builtin").lsp_type_definitions()<CR>
nnoremap [e <Cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap ]e <Cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap K <Cmd>call <SID>show_documentation()<CR>
