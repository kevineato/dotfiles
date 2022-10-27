local utils = {}

utils.buf_kill = function(kill_command, bufnr, swap, force)
    local bo = vim.bo
    local api = vim.api
    local alt_bufnr = vim.fn.bufnr("#")

    -- If buffer is modified and force isn't true, print error and abort
    if not force and bo[bufnr].modified then
        return api.nvim_err_writeln(
            string.format(
                "No write since last change for buffer %d (set force to true to override)",
                bufnr
            )
        )
    end

    if bufnr == 0 or bufnr == nil then
        bufnr = api.nvim_get_current_buf()
    end

    if force then
        kill_command = kill_command .. "!"
    end

    -- Get list of windows IDs with the buffer to close
    local windows = vim.tbl_filter(function(win)
        return api.nvim_win_get_buf(win) == bufnr
    end, api.nvim_list_wins())

    -- Get list of active buffers
    local buffers = vim.tbl_filter(function(buf)
        return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
    end, api.nvim_list_bufs())

    -- If there is only one buffer (which has to be the current one), vim will
    -- create a new buffer on :bd.
    -- For more than one buffer, pick the prev buffer (wrapping around if necessary)
    if #buffers > 1 then
        for i, v in ipairs(buffers) do
            if v == bufnr then
                local prev_buffer = buffers[i - 1 == 0 and #buffers or i - 1]
                for _, win in ipairs(windows) do
                    api.nvim_win_set_buf(win, prev_buffer)
                end
            end
        end
    end

    -- Check if buffer still exists, to ensure the target buffer wasn't killed
    -- due to options like bufhidden=wipe.
    if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
        if
            swap
            and api.nvim_buf_is_valid(alt_bufnr)
            and bo[alt_bufnr].buflisted
        then
            vim.cmd(string.format("b %d", alt_bufnr))
        end
        vim.cmd(string.format("%s %d", kill_command, bufnr))
    end
end

utils.align_comment = function()
    local api = vim.api
    local clients = vim.tbl_filter(function(client)
        return client.name == "clangd"
    end, vim.lsp.get_active_clients())
    if #clients == 0 then
        return
    end
    local client = clients[1]
    local save_pos = api.nvim_win_get_cursor(0)
    local tab_intro = [[call Tabularize('/.*\*/l1')]]
    local tab_param = [[call Tabularize('/.*@t\?param\%(\[.*]\)\? \+\zs\w\+]]
    local tab_ret = [[call Tabularize('/.*@returns\?\zs \|\*\zs \?/l0')]]

    local c_begin = vim.fn.search([[\/\*\*]], "bcn")
    local c_end = vim.fn.search([[\*\/]], "cn")

    local prev_text = api.nvim_buf_get_lines(0, c_begin, c_end, false)
    local curr_text = {}

    local function tables_equal(table1, table2)
        if #table1 ~= #table2 then
            return false
        end

        for i, value in ipairs(table1) do
            if value ~= table2[i] then
                return false
            end
        end

        return true
    end

    while not tables_equal(curr_text, prev_text) do
        prev_text = api.nvim_buf_get_lines(0, c_begin, c_end, false)

        if c_begin + 1 ~= c_end - 1 then
            api.nvim_command(
                tostring(c_begin + 1) .. "," .. tostring(c_end - 1) .. tab_intro
            )
        end
        api.nvim_call_function("cursor", { c_begin, save_pos[2] })
        if vim.fn.search([[@t\?param]], "", c_end) ~= 0 then
            local p_begin = api.nvim_win_get_cursor(0)[1]
            while vim.fn.search([[@t\?param]], "", c_end) ~= 0 do
            end
            local p_end = api.nvim_win_get_cursor(0)[1]
            if vim.fn.search("@return", "", c_end) == 0 then
                p_end = c_end - 1
            else
                p_end = api.nvim_win_get_cursor(0)[1] - 1
            end
            local p_tail = [[/l1l1')]]
            if p_begin == p_end then
                api.nvim_command(
                    tostring(p_begin)
                        .. ","
                        .. tostring(p_end)
                        .. tab_param
                        .. p_tail
                )
            else
                api.nvim_command(
                    tostring(p_begin)
                        .. ","
                        .. tostring(p_end)
                        .. tab_param
                        .. [[\|\*\zs \?]]
                        .. p_tail
                )
            end
        end
        if vim.fn.search("@return", "c", c_end) ~= 0 then
            local r_begin = api.nvim_win_get_cursor(0)[1]
            if r_begin ~= c_end - 1 then
                api.nvim_command(
                    tostring(r_begin) .. "," .. tostring(c_end - 1) .. tab_ret
                )
            end
        end

        vim.fn.search([[\s*\/\*\*]], "bc")
        local start = api.nvim_win_get_cursor(0)
        vim.fn.search([[\s*\*\+\/]], "c")
        local ending = api.nvim_win_get_cursor(0)
        local results = vim.lsp.buf_request_sync(
            0,
            "textDocument/rangeFormatting",
            vim.lsp.util.make_given_range_params(start, ending)
        )
        local edits = {}
        for _, result in pairs(results) do
            if result.result then
                edits = result.result
            end
        end
        if edits then
            vim.lsp.util.apply_text_edits(edits, 0, client.offset_encoding)
        end

        api.nvim_call_function("cursor", save_pos)

        c_begin = vim.fn.search([[\/\*\*]], "bcn")
        c_end = vim.fn.search([[\*\/]], "cn")

        curr_text = api.nvim_buf_get_lines(0, c_begin, c_end, false)
    end
    api.nvim_call_function("cursor", save_pos)
end

utils.packer_lazy_load = function(plugin, timer)
    if plugin then
        timer = timer or 0
        vim.defer_fn(function()
            require("packer").loader(plugin)
        end, timer)
    end
end

local fix_normal_hl_links = function()
    local tokens = function(s, token_patt)
        local token_list = {}
        for token in s:gmatch(token_patt) do
            table.insert(token_list, token)
        end
        return token_list
    end

    local find_key = function(tbl, value)
        for k, v in pairs(tbl) do
            if v == value then
                return k
            end
        end
        return nil
    end

    local get_link_name = function(gp_tokens)
        local links_token = find_key(gp_tokens, "links")
        if links_token ~= nil then
            local to_token = links_token + 1
            if gp_tokens[to_token] ~= "to" then
                error(
                    "Expected token 'to' after 'links' in highlight command output"
                )
            end
            local link_dest = to_token + 1
            return gp_tokens[link_dest]
        else
            return nil
        end
    end

    local append_table = function(dst, src)
        for _, v in ipairs(src) do
            table.insert(dst, v)
        end
    end

    local starts_with = function(str, start)
        return str:sub(1, #start) == start
    end

    local normal_tokens =
        tokens(vim.api.nvim_exec("highlight Normal", true), "%S+")
    if get_link_name(normal_tokens) ~= nil then
        error("Link inside 'Normal' group not supported")
    end

    if find_key(normal_tokens, "cleared") ~= nil then
        return
    end

    -- link inside highlight group overrides any other settings?

    local hi_lines = tokens(vim.api.nvim_exec("highlight", true), "[^\r\n]+")

    for k, v in ipairs(hi_lines) do
        hi_lines[k] = tokens(v, "%S+")
    end

    local i = 1
    while hi_lines[i] ~= nil do
        local token_list = hi_lines[i]
        if
            #token_list > 2
            and token_list[1] == "links"
            and token_list[2] == "to"
        then
            append_table(hi_lines[i - 1], token_list)
            table.remove(hi_lines, i)
        else
            i = i + 1
        end
    end

    local normal_line = ""
    -- skip "Normal xxx"
    for j = 3, #normal_tokens do
        local token = normal_tokens[j]
        if
            not starts_with(token, "ctermbg=")
            and not starts_with(token, "guibg=")
        then
            normal_line = normal_line .. " " .. token
        end
    end

    local normal_copy = "NormalWithoutBg"
    vim.api.nvim_exec("highlight clear " .. normal_copy, true)
    vim.api.nvim_exec("highlight " .. normal_copy .. normal_line, true)

    for _, line in ipairs(hi_lines) do
        if get_link_name(line) == "Normal" then
            local group_name = line[1]
            vim.api.nvim_exec(
                "highlight! link " .. group_name .. " " .. normal_copy,
                true
            )
        end
    end
end

utils.fix_ts_highlights = function()
    local hl = function(group, opts)
        opts.default = true
        vim.api.nvim_set_hl(0, group, opts)
    end

    hl("@comment", { link = "Comment" })
    -- hl('@error', { link = 'Error' })
    hl("@none", { bg = "NONE", fg = "NONE" })
    hl("@preproc", { link = "PreProc" })
    hl("@define", { link = "Define" })
    hl("@operator", { link = "Operator" })
    hl("@punctuation.delimiter", { link = "Delimiter" })
    hl("@punctuation.bracket", { link = "Delimiter" })
    hl("@punctuation.special", { link = "Delimiter" })
    hl("@string", { link = "String" })
    hl("@string.regex", { link = "String" })
    hl("@string.escape", { link = "SpecialChar" })
    hl("@string.special", { link = "SpecialChar" })
    hl("@character", { link = "Character" })
    hl("@character.special", { link = "SpecialChar" })
    hl("@boolean", { link = "Boolean" })
    hl("@number", { link = "Number" })
    hl("@float", { link = "Float" })
    hl("@function", { link = "Function" })
    hl("@function.call", { link = "Function" })
    hl("@function.builtin", { link = "Special" })
    hl("@function.macro", { link = "Macro" })
    hl("@method", { link = "Function" })
    hl("@method.call", { link = "Function" })
    hl("@constructor", { link = "Special" })
    hl("@parameter", { link = "Identifier" })
    hl("@keyword", { link = "Keyword" })
    hl("@keyword.function", { link = "Keyword" })
    hl("@keyword.operator", { link = "Keyword" })
    hl("@keyword.return", { link = "Keyword" })
    hl("@conditional", { link = "Conditional" })
    hl("@repeat", { link = "Repeat" })
    hl("@debug", { link = "Debug" })
    hl("@label", { link = "Label" })
    hl("@include", { link = "Include" })
    hl("@exception", { link = "Exception" })
    hl("@type", { link = "Type" })
    hl("@type.builtin", { link = "Type" })
    hl("@type.qualifier", { link = "Type" })
    hl("@type.definition", { link = "Typedef" })
    hl("@storageclass", { link = "StorageClass" })
    hl("@attribute", { link = "PreProc" })
    hl("@field", { link = "Identifier" })
    hl("@property", { link = "Identifier" })
    hl("@variable", { link = "Normal" })
    hl("@variable.builtin", { link = "Special" })
    hl("@constant", { link = "Constant" })
    hl("@constant.builtin", { link = "Special" })
    hl("@constant.macro", { link = "Define" })
    hl("@namespace", { link = "Include" })
    hl("@symbol", { link = "Identifier" })
    hl("@text", { link = "Normal" })
    hl("@text.strong", { bold = true })
    hl("@text.emphasis", { italic = true })
    hl("@text.underline", { underline = true })
    hl("@text.strike", { strikethrough = true })
    hl("@text.title", { link = "Title" })
    hl("@text.literal", { link = "String" })
    hl("@text.uri", { link = "Underlined" })
    hl("@text.math", { link = "Special" })
    hl("@text.environment", { link = "Macro" })
    hl("@text.environment.name", { link = "Type" })
    hl("@text.reference", { link = "Constant" })
    hl("@text.todo", { link = "Todo" })
    hl("@text.note", { link = "SpecialComment" })
    hl("@text.warning", { link = "WarningMsg" })
    hl("@text.danger", { link = "ErrorMsg" })
    hl("@tag", { link = "Tag" })
    hl("@tag.attribute", { link = "Identifier" })
    hl("@tag.delimiter", { link = "Delimiter" })

    fix_normal_hl_links()
end

return utils
