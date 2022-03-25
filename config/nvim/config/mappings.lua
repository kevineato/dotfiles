local map = require("cosmic.utils").map

map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("x", "<", "<gv")
map("x", ">", ">gv")
map("n", "H", "^")
map("x", "H", "^")
map("o", "H", "^")
map("n", "L", "g_")
map("x", "L", "g_")
map("o", "L", "g_")
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "]t", "<Cmd>tabnext<CR>")
map("n", "[t", "<Cmd>tabprevious<CR>")
map(
    "n",
    "<Leader><Tab>",
    [[bufloaded(bufnr('#')) ? '<Cmd>b #<CR>' : exists(':BufferLineCyclePrev') == 2 ? '<Cmd>BufferLineCyclePrev<CR>' : '<Cmd>bp<CR>']],
    { expr = true }
)
map("n", "<Leader>d", '"_d')
map("x", "<Leader>d", '"_d')
map("x", "<Leader>p", '"_dP')
map(
    "n",
    "<Leader>x",
    "<Cmd>lua require('cosmic.config.utils').buf_kill('bd', 0, true)<CR>"
)
