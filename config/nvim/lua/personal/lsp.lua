-- local t = function(str)
    -- return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- local lspkind = require("lspkind")
-- local cmp = require("cmp")

-- cmp.setup({
    -- snippet = {
        -- expand = function(args)
            -- vim.fn["UltiSnips#Anon"](args.body)
        -- end
    -- },
    -- mapping = {
        -- ["<Tab>"] = cmp.mapping({
            -- c = function()
                -- if cmp.visible() then
                    -- cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
                -- else
                    -- cmp.complete()
                -- end
            -- end,
            -- i = function(fallback)
                -- if cmp.visible() then
                    -- cmp.select_next_item({behavior = cmp.SelectBehavior.Insert})
                -- elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    -- vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
                -- else
                    -- fallback()
                -- end
            -- end,
            -- s = function(fallback)
                -- if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    -- vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
                -- else
                    -- fallback()
                -- end
            -- end
        -- }),
        -- ["<S-Tab>"] = cmp.mapping({
            -- c = function()
                -- if cmp.visible() then
                    -- cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
                -- else
                    -- cmp.complete()
                -- end
            -- end,
            -- i = function(fallback)
                -- if cmp.visible() then
                    -- cmp.select_prev_item({behavior = cmp.SelectBehavior.Insert})
                -- elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    -- return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
                -- else
                    -- fallback()
                -- end
            -- end,
            -- s = function(fallback)
                -- if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                    -- return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
                -- else
                    -- fallback()
                -- end
            -- end
        -- }),
        -- ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), {"i"}),
        -- ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), {"i"}),
        -- ["<C-n>"] = cmp.mapping({
            -- c = function()
                -- if cmp.visible() then
                    -- cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                -- else
                    -- vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                -- end
            -- end,
            -- i = function(fallback)
                -- if cmp.visible() then
                    -- cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                -- else
                    -- fallback()
                -- end
            -- end
        -- }),
        -- ["<C-p>"] = cmp.mapping({
            -- c = function()
                -- if cmp.visible() then
                    -- cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                -- else
                    -- vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                -- end
            -- end,
            -- i = function(fallback)
                -- if cmp.visible() then
                    -- cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                -- else
                    -- fallback()
                -- end
            -- end
        -- }),
        -- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
        -- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
        -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        -- ["<C-e>"] = cmp.mapping({i = cmp.mapping.close(), c = cmp.mapping.close()}),
        -- ["<CR>"] = cmp.mapping({
            -- i = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false}),
            -- c = function(fallback)
                -- if cmp.visible() and cmp.get_selected_entry() then
                    -- cmp.confirm({behavior = cmp.ConfirmBehavior.Replace})
                -- else
                    -- fallback()
                -- end
            -- end
        -- }),
    -- },
    -- formatting = {
        -- format = lspkind.cmp_format({maxwdith = 50})
    -- },
    -- sources = cmp.config.sources({
        -- {name = "nvim_lsp"},
        -- {name = "ultisnips"},
        -- {name = "buffer", option = {keyword_pattern = [[\k\+]]}},
        -- {name = "path"}
    -- })
-- })

-- cmp.setup.cmdline("/", {
    -- sources = cmp.config.sources({
        -- {name = "buffer", option = {keyword_pattern = [[\k\+]]}},
    -- })
-- })

-- cmp.setup.cmdline(":", {
    -- sources = cmp.config.sources({
        -- {name = "cmdline"},
        -- {name = "path"}
    -- })
-- })

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.g.coq_settings = {auto_start = "shut-up"}
local capabilities = require("coq").lsp_ensure_capabilities(capabilities)
-- capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = capabilities,
    }, _config or {})
end

local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
    "bashls",
    "clangd",
    "cmake",
    "pyright",
    "sumneko_lua",
    "vimls"
}

for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer.get_server(server_name)
    if server_available and not server:is_installed() then
        server:install()
    end
end

local function on_attach(client, bufnr)
end

local server_opts = {
    ["clangd"] = function(opts)
        opts.cmd_args = {
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
        }
        opts.filetypes = {"c", "cpp", "h", "hpp", "tpp", "objc", "objcpp"}
        opts.root_dir = lspconfig.util.root_pattern(
            "build/compile_commands.json",
            "compile_commands.json"
        )
        opts.single_file_support = true
    end,
    ["sumneko_lua"] = function(opts)
        opts.settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = runtime_path
                },
                diagnostics = {
                    globals = {"vim"}
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true)
                },
                telemetry = {
                    enable = false
                }
            }
        }
    end
}

lsp_installer.on_server_ready(function(server)
    local opts = config({on_attach = on_attach})

    if server_opts[server.name] then
        server_opts[server.name](opts)
    end

    server:setup(opts)
end)

vim.diagnostic.config({
    virtual_text = {
        spacing = 2
    }
})

vim.g.symbols_outline = {
    width = 50,
    highlight_hovered_item = true,
    show_guides = true
}
