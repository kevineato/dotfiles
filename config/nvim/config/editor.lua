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
opt.linebreak = true
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.showbreak = " "
opt.showmode = false
opt.sidescrolloff = 5
opt.signcolumn = "auto:2"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.wrap = false

local api = vim.api
local buf_map = require("cosmic.utils").buf_map
local personal_group =
    api.nvim_create_augroup("personal_group", { clear = true })
api.nvim_create_autocmd("FileType", {
    group = personal_group,
    pattern = "c,cpp,h,hpp,java",
    callback = function()
        buf_map(0, "n", config.mapleader.as_code .. "ca", function()
            require("cosmic.config.utils").align_comment()
        end)
    end,
})
api.nvim_create_autocmd("FileType", {
    group = personal_group,
    pattern = "help,man",
    callback = function()
        buf_map(0, "n", "q", function()
            require("cosmic.config.utils").buf_kill("bd", 0, true)
            vim.schedule(function()
                api.nvim_win_close(0, true)
            end)
        end)
        buf_map(0, "n", "d", "<C-d>")
        buf_map(0, "n", "u", "<C-u>")
    end,
})
api.nvim_create_autocmd("TextYankPost", {
    group = personal_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150,
            on_visual = true,
        })
    end,
})

require("cosmic.config.mappings")
