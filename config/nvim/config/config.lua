local config = {}

config.mapleader = " "

config.add_plugins = {
    {
        "godlygeek/tabular",
        ft = {"c", "cpp", "h", "hpp", "java"}
    },
    {
        "ethanholz/nvim-lastplace",
        config = function()
            require("nvim-lastplace").setup()
        end
    },
    {
        "nvim-treesitter/playground",
        requires = "nvim-treesitter",
        cmd = {"TSPlaygroundToggle", "TSHighlightCapturesUnderCursor"}
    },
    {
        "romgrk/nvim-treesitter-context",
        requires = "nvim-treesitter",
        config = function()
            require("treesitter-context").setup({
                patterns = {
                    default = {
                        "class",
                        "function",
                        "method",
                        "for",
                        "while",
                        "if",
                        "switch",
                        "case"
                    }
                }
            })
        end
    },
    {
        "sbdchd/neoformat",
        keys = {
            {"n", config.mapleader .. "nf"},
            {"x", config.mapleader .. "nf"}
        },
        cmd = "Neoformat",
        config = function()
            local map = require("cosmic.utils").map
            local mapleader = require("cosmic.config.config").mapleader
            map("n", mapleader .. "nf", "<Cmd>Neoformat<CR>")
            map("x", mapleader .. "nf", "<Cmd>Neoformat<CR>")
        end
    },
    {
        "sainnhe/gruvbox-material",
        setup = function()
            require("cosmic.config.utils").packer_lazy_load("gruvbox-material")
        end,
        config = function()
            vim.g.gruvbox_material_background = "hard"
            vim.g.gruvbox_material_current_word = "underline"
            vim.g.gruvbox_material_diagnostic_line_highlight = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
        end
    },
    {
        "danymat/neogen",
        requires = "nvim-treesitter",
        keys = {
            {"n", config.mapleader .. "af"},
            {"n", config.mapleader .. "ac"},
            {"n", config.mapleader .. "ai"}
        },
        config = function()
            require("neogen").setup({
                enabled = true
            })

            local map = require("cosmic.utils").map
            local mapleader = require("cosmic.config.config").mapleader
            map("n", mapleader .. "af", "<Cmd>lua require('neogen').generate({type = 'func'})<CR>")
            map("n", mapleader .. "ac", "<Cmd>lua require('neogen').generate({type = 'class'})<CR>")
            map("n", mapleader .. "ai", "<Cmd>lua require('neogen').generate({type = 'file'})<CR>")
        end
    },
    {
        "mhinz/vim-signify",
        config = function()
            vim.g.signify_vcs_cmds = {
                git = "git diff --no-color --no-ext-diff -U0 -- %f",
                yadm = "yadm diff --no-color --no-ext-diff -U0 -- %f",
                hg = "hg diff --color=never --config aliases.diff= --nodates -U0 -- %f",
                svn = "svn diff --diff-cmd %d -x -U0 -- %f",
                bzr = "bzr diff --using %d --diff-options=-U0 -- %f",
                darcs = "darcs diff --no-pause-for-gui --no-unified --diff-opts=-U0 -- %f",
                fossil = "fossil diff --unified -c 0 -- %f",
                cvs = "cvs diff -U0 -- %f",
                rcs = "rcsdiff -U0 %f 2>%n",
                accurev = "accurev diff %f -- -U0",
                perforce = "p4 info " .. vim.fn["sy#util#shell_redirect"]("%n") .. (vim.fn.has('win32') and " &&" or " && env P4DIFF= P4COLORS=") .. " p4 diff -du0 %f",
                tfs = "tf diff -version:W -noprompt -format:Unified %f"
            }
            vim.g.signify_vcs_cmds_diffmode = {
                git = "git show HEAD:./%f",
                yadm = "yadm show HEAD:./%f",
                hg = "hg cat %f",
                svn = "svn cat %f",
                bzr = "bzr cat %f",
                darcs = "darcs show contents -- %f",
                fossil = "fossil cat %f",
                cvs = "cvs up -p -- %f 2>%n",
                rcs = "co -q -p %f",
                accurev = "accurev cat %f",
                perforce = "p4 print %f",
                tfs = "tf view -version:W -noprompt %f",
            }

            local map = require("cosmic.utils").map
            local mapleader = require("cosmic.config.config").mapleader
            map("n", mapleader .. "hd", "<Cmd>SignifyHunkDiff<CR>")
            map("n", mapleader .. "hu", "<Cmd>SignifyHunkUndo<CR>")
        end
    },
    "tpope/vim-repeat",
    {
        "machakann/vim-sandwich",
        requires = "vim-repeat",
        keys = {
            {"n", "ys"},
            {"n", "ds"},
            {"n", "cs"},
            {"x", "gs"},
            {"x", "is"},
            {"x", "as"},
            {"o", "is"},
            {"o", "as"},
            {"x", "im"},
            {"x", "am"},
            {"o", "im"},
            {"o", "am"}
        },
        setup = function()
            vim.g.sandwich_no_default_key_mappings = true
        end,
        config = function()
            vim.cmd("runtime autoload/sandwich.vim")
            local sandwich_recipes = vim.deepcopy(vim.g["sandwich#default_recipes"])
            vim.list_extend(sandwich_recipes, {
                {
                    buns = {"{ ", " }"},
                    nesting = 1,
                    match_syntax = 1,
                    kind = {"add", "replace"},
                    action = {"add"},
                    input = {"}"}
                },
                {
                    buns = {"{", "}"},
                    kind = {"add", "replace"},
                    action = {"add"},
                    motionwise = {"line"},
                    command = {"'[+1,']-1normal! =="}
                },
                {
                    buns = {[[^\s*{$]], [[^\s*}$]]},
                    nesting = 1,
                    regex = 1,
                    linewise = 1,
                    match_syntax = 1,
                    kind = {"delete", "replace", "textobj"},
                    action = {"delete"},
                    input = {"{{"},
                    command = {"'[,']normal! =="}
                },
                {
                    buns = {"[ ", " ]"},
                    nesting = 1,
                    match_syntax = 1,
                    kind = {"add", "replace"},
                    action = {"add"},
                    input = {"]"}
                },
                {
                    buns = {"<", ">"},
                    nesting = 1,
                    match_syntax = 1,
                    kind = {"add", "replace"},
                    action = {"add"},
                    input = {"<"}
                },
                {
                    buns = {"< ", " >"},
                    nesting = 1,
                    match_syntax = 1,
                    kind = {"add", "replace"},
                    action = {"add"},
                    input = {">"}
                },
                {
                    buns = {"( ", " )"},
                    nesting = 1,
                    match_syntax = 1,
                    kind = {"add", "replace"},
                    action = {"add"},
                    input = {")"}
                },
                {
                    buns = {[[{\s*]], [[\s*}]]},
                    nesting = 1,
                    regex = 1,
                    match_syntax = 1,
                    kind = {"delete", "replace", "textobj"},
                    action = {"delete"},
                    input = {"{"}
                },
                {
                    buns = {[=[\[\s*]=], [=[\s*\]]=]},
                    nesting = 1,
                    regex = 1,
                    match_syntax = 1,
                    kind = {"delete", "replace", "textobj"},
                    action = {"delete"},
                    input = {"["}
                },
                {
                    buns = {[[<\s*]], [[\s*>]]},
                    nesting = 1,
                    regex = 1,
                    match_syntax = 1,
                    kind = {"delete", "replace", "textobj"},
                    action = {"delete"},
                    input = {"<"}
                },
                {
                    buns = {[[(\s*]], [[\s*)]]},
                    nesting = 1,
                    regex = 1,
                    match_syntax = 1,
                    kind = {"delete", "replace", "textobj"},
                    action = {"delete"},
                    input = {"<"}
                },
                {
                    buns = {[[\s\@<=\%(\k\|:\)*<\s*]], [[\s*>]]},
                    nesting = 1,
                    regex = 1,
                    match_syntax = 1,
                    kind = {"delete", "replace", "textobj"},
                    action = {"delete"},
                    input = {"p"}
                }
            })
            vim.g["sandwich#recipes"] = sandwich_recipes

            local map = require("cosmic.utils").map
            vim.cmd("runtime autoload/repeat.vim")
            map("n", ".", "<Plug>(operator-sandwich-predot)<Plug>(RepeatDot)", {noremap = false, silent = false})
            map("n", "ys", "<Plug>(sandwich-add)", {noremap = false, silent = false})
            map("n", "ds", "<Plug>(sandwich-delete)", {noremap = false, silent = false})
            map("n", "cs", "<Plug>(sandwich-replace)", {noremap = false, silent = false})
            map("x", "gs", "<Plug>(sandwich-add)", {noremap = false, silent = false})
            map("x", "is", "<Plug>(textobj-sandwich-query-i)", {noremap = false, silent = false})
            map("x", "as", "<Plug>(textobj-sandwich-query-a)", {noremap = false, silent = false})
            map("o", "is", "<Plug>(textobj-sandwich-query-i)", {noremap = false, silent = false})
            map("o", "as", "<Plug>(textobj-sandwich-query-a)", {noremap = false, silent = false})
            map("x", "im", "<Plug>(textobj-sandwich-literal-query-i)", {noremap = false, silent = false})
            map("x", "am", "<Plug>(textobj-sandwich-literal-query-a)", {noremap = false, silent = false})
            map("o", "im", "<Plug>(textobj-sandwich-literal-query-i)", {noremap = false, silent = false})
            map("o", "am", "<Plug>(textobj-sandwich-literal-query-a)", {noremap = false, silent = false})
        end
    },
    {
        "ggandor/lightspeed.nvim",
        after = {"vim-repeat", "vim-sandwich"},
        keys = {
            {"n", "s"},
            {"n", "S"},
            {"x", "s"},
            {"x", "S"},
            {"n", "gs"},
            {"n", "gS"},
            {"o", "z"},
            {"o", "Z"},
            {"o", "x"},
            {"o", "X"},
            {"", "f"},
            {"", "F"},
            {"", "t"},
            {"", "T"},
            {"", ";"},
            {"", ","}
        }
    },
    {
        "tamago324/lir.nvim",
        keys = "-",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            local actions = require("lir.actions")
            local mark_actions = require("lir.mark.actions")
            local clipboard_actions = require("lir.clipboard.actions")
            local function no_new_window_edit()
                actions.edit({modified_split_command = "edit"})
            end

            require("lir").setup({
                show_hidden_files = true,
                devicons_enable = true,
                mappings = {
                    ["l"]     = no_new_window_edit,
                    ["<CR>"]  = no_new_window_edit,
                    ["<C-s>"] = actions.split,
                    ["<C-v>"] = actions.vsplit,

                    ["h"]     = actions.up,
                    ["-"]     = actions.up,
                    ["q"]     = actions.quit,

                    ["A"]     = actions.mkdir,
                    ["a"]     = function()
                        local name = vim.fn.input("Create file: ")
                        if name == "" then
                            return
                        end

                        local Path = require("plenary.path")
                        local ctx = require("lir.vim").get_context()

                        local path = Path:new(ctx.dir .. name)
                        if path:exists() then
                            require("lir.utils").error("File already exists")
                            local lnum = ctx:indexof(name)
                            if lnum then
                                vim.cmd(tostring(lnum))
                            end
                            return
                        end

                        path:touch({parents = true})

                        actions.reload()

                        vim.schedule(function()
                            local lnum = require("lir.vim").get_context():indexof(name)
                            if lnum then
                                vim.cmd(tostring(lnum))
                            end
                        end)
                    end,
                    ["r"]     = actions.rename,
                    ["@"]     = actions.cd,
                    ["y"]     = actions.yank_path,
                    ["."]     = actions.toggle_show_hidden,
                    ["d"]     = actions.delete,

                    ["J"] = function()
                        mark_actions.toggle_mark()
                        vim.cmd("normal! j")
                    end,
                    ["K"] = function()
                        mark_actions.toggle_mark()
                        vim.cmd("normal! k")
                    end,
                    ["c"] = clipboard_actions.copy,
                    ["x"] = clipboard_actions.cut,
                    ["p"] = clipboard_actions.paste,
                },
                float = {
                    winblend = 0,
                    curdir_window = {
                        enable = false,
                        highlight_dirname = false
                    },
                    win_opts = function()
                        local width = math.floor(vim.o.columns * 0.8)
                        local height = math.floor(vim.o.lines * 0.8)
                        return {
                            border = require("lir.float.helper").make_border_opts({
                                "+", "─", "+", "│", "+", "─", "+", "│",
                            }, "Normal"),
                            width = width,
                            height = height,
                            row = 1,
                            col = math.floor((vim.o.columns - width) / 2),
                        }
                    end
                },
                hide_cursor = true
            })

            require("nvim-web-devicons").set_icon({
                lir_folder_icon = {
                    icon = "",
                    color = "#7ebae4",
                    name = "LirFolderNode"
                }
            })

            require("cosmic.utils").map("n", "-", "<Cmd>lua require('lir.float').toggle()<CR>")
        end
    },
    {
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        event = "BufEnter",
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = function(opts)
                        return string.format("%s·%s", opts.raise(opts.id), opts.lower(opts.ordinal))
                    end,
                    close_command = function(id)
                        require("cosmic.config.utils").buf_kill("bd", tonumber(id))
                    end,
                    right_mouse_command = function(id)
                        require("cosmic.config.utils").buf_kill("bd", tonumber(id))
                    end,
                    offsets = {{filetype = "NvimTree", text = "File Explorer"}},
                    separator_style = "slant",
                    sort_by = "id"
                }
            })

            local map = require("cosmic.utils").map
            local mapleader = require("cosmic.config.config").mapleader
            map("n", mapleader .. "bb", "<Cmd>BufferLinePick<CR>")
            map("n", mapleader .. "bx", "<Cmd>BufferLinePickClose<CR>")
            map("n", "]b", "<Cmd>BufferLineCycleNext<CR>")
            map("n", "[b", "<Cmd>BufferLineCyclePrev<CR>")
            map("n", "]t", "<Cmd>BufferLineMoveNext<CR>")
            map("n", "[t", "<Cmd>BufferLineMovePrev<CR>")
            map("n", mapleader .. "bd", "<Cmd>BufferLineSortByDirectory<CR>")
            map("n", mapleader .. "bi", "<Cmd>lua require('bufferline').sort_buffers_by(function(buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>")
        end
    }
}

config.disable_builtin_plugins = {
    "fugitive",
    "gitsigns",
    "todo-comments"
}

config.theme = "gruvbox"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
    "bashls",
    "clangd",
    "cmake",
    "null_ls",
    "pyright",
    "sumneko_lua",
    "vimls"
}

local server_opts = {
    clangd = {
        opts = function(lspconfig)
            return {
                cmd_args = {
                    "--all-scopes-completion",
                    "--background-index",
                    "--clang-tidy",
                    "--compile-commands-dir=build",
                    "--completion-style=detailed",
                    "--header-insertion=never",
                    "--hidden-features",
                    "--inlay-hints",
                    "-j=12",
                    "--ranking-model=decision_forest"
                },
                filetypes = {"c", "cpp", "h", "hpp", "tpp", "objc", "objcpp"},
                root_dir = lspconfig.util.root_pattern(
                    "build/compile_commands.json",
                    "compile_commands.json"
                ),
                single_file_support = true,
                capabilities = {
                    offsetEncoding = {"utf-16"}
                }
            }
        end
    },
    null_ls = {
        setup = function(null_ls)
            return {
                diagnostics_format = "#{m} [#{c}]",
                sources = {
                    null_ls.builtins.diagnostics.shellcheck.with({
                        extra_filetypes = {"zsh"}
                    }),
                    null_ls.builtins.formatting.cmake_format,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.diagnostics.flake8.with({
                        extra_args = {"--max-line-length=88", "--extend-ignore=E203,E302"}
                    })
                },
                default_cosmic_sources = false
            }
        end
    },
    sumneko_lua = {
        opts = {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = runtime_path,
                        pathStrict = false
                    },
                    diagnostics = {
                        globals = {"vim"}
                    },
                    workspace = {
                        library = {
                            vim.fn.expand("$VIMRUNTIME/lua"),
                            vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                            vim.fn.stdpath("config") .. "/lua",
                            vim.fn.stdpath("data") .. "/site/pack/packer"
                        }
                    },
                    telemetry = {
                        enable = false
                    }
                }
            }
        }
    }
}

local server_formats = {
    clangd = true,
    null_ls = true
}

config.lsp = {
    format_on_save = false,
    rename_notification = true,
    servers = {}
}

for _, server_name in ipairs(servers) do
    if server_opts[server_name] then
        config.lsp.servers[server_name] = server_opts[server_name]
        if server_formats[server_name] ~= nil then
            config.lsp.servers[server_name].format = server_formats[server_name]
        end
    else
        config.lsp.servers[server_name] = {
            format = false
        }
        if server_formats[server_name] ~= nil then
            config.lsp.servers[server_name].format = server_formats[server_name]
        end
    end
end

config.diagnostic = {
    virtual_text = {
        spacing = 2
    }
}

config.lsp_signature = {
    hint_prefix = " ",
    toggle_key = "<C-k>"
}

config.treesitter = {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "html",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "markdown",
        "python",
        "tsx",
        "typescript",
        "yaml"
    },
    indent = {
        enable = false
    }
}

-- local cmp = require("cmp")
-- config.nvim_cmp = {
--     mapping = {
--         ["<CR>"] = cmp.mapping.confirm({
--             behavior = cmp.ConfirmBehavior.Replace,
--             select = true
--         })
--     }
-- }

config.nvim_tree = {
    git = {
        ignore = false
    },
    update_to_buf_dir = {
        enable = false
    }
}

config.todo_comments = {
    highlight = {
        before = "",
        keyword = "bg",
        after = "",
        pattern = [=[.*<\@?(KEYWORDS)[[:space:][:alnum:]()]*:]=]
    },
    search = {
        pattern = [=[\b@?(KEYWORDS)[[:space:][:alnum:]()]*:]=]
    }
}

return config
