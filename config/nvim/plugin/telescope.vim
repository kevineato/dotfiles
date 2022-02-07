nnoremap <silent> <Leader>b <Cmd>lua require("telescope.builtin").buffers()<CR>
nnoremap <silent> <Leader>e <Cmd>lua require("telescope.builtin").find_files()<CR>
nnoremap <silent> <Leader>ed <Cmd>lua require("telescope.builtin").find_files({cwd = require("telescope.utils").buffer_dir()})<CR>
nnoremap <silent> <Leader>f <Cmd>lua require("telescope.builtin").live_grep()<CR>
nnoremap <silent> <Leader>fd <Cmd>lua require("telescope.builtin").live_grep({cwd = require("telescope.utils").buffer_dir()})<CR>
nnoremap <silent> <Leader>ls <Cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>
nnoremap <silent> <Leader>r <Cmd>lua require("telescope.builtin").resume()<CR>
