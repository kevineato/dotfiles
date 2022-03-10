local opt = vim.opt
local indent = 4
local config = require("cosmic.config.config")

vim.g.mapleader = config.mapleader.as_string

-- behavior
opt.backup = false
opt.clipboard = "unnamedplus"
opt.inccommand = "split"
opt.lazyredraw = true
-- opt.redrawtime = 2000
opt.sessionoptions:remove("blank")
opt.shortmess:append("c")
opt.swapfile = true
opt.timeoutlen = 300
opt.ttimeoutlen = 50
opt.undodir = vim.fn.stdpath("data") .. "/.undo"
opt.undofile = true
-- opt.updatetime = 50
opt.writebackup = true

-- completion
opt.completeopt = { "menu", "menuone", "preview", "noinsert", "noselect" }
opt.wildignore = {}
opt.wildmenu = true
opt.wildmode = { "longest:full", "full" }

-- indent
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = false
opt.softtabstop = indent
opt.tabstop = indent

-- search
opt.ignorecase = true
opt.hlsearch = false
opt.smartcase = true

-- ui
opt.breakindent = true
opt.breakindentopt = { "sbr", "list:-1" }
opt.cmdheight = 1
opt.colorcolumn = "80"
opt.cursorline = true
opt.laststatus = 2
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.ruler = true
-- opt.scrolloff = 0
opt.showbreak = " "
opt.showmode = false
-- opt.sidescrolloff = 0
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.wrap = true

vim.defer_fn(function()
	vim.cmd([[
        highlight Comment cterm=NONE gui=NONE
        highlight TSComment gui=NONE
        highlight Todo gui=bold
    ]])
end, 0)

vim.cmd([[
    augroup personal_group
        au!
        au User PackerCompileDone highlight Comment cterm=NONE gui=NONE
        au User PackerCompileDone highlight TSComment gui=NONE
        au User PackerCompileDone highlight Todo gui=bold
        au TextYankPost * lua vim.highlight.on_yank({higroup = "IncSearch", timeout = 150, on_visual = true})
        au FileType c,cpp,h,hpp,java nnoremap <buffer> ]] .. config.mapleader.as_code .. [[ca <Cmd>lua require("cosmic.config.utils").align_comment()<CR>
    augroup end
]])

require("cosmic.config.mappings")
