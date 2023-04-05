local map = require("cosmic.utils").map

map({ "n", "x" }, "<Leader>w", "<C-w>")
map("n", "<M-h>", "zh")
map("n", "<M-S-h>", "zH")
map("n", "<M-j>", "<C-e>")
map("n", "<M-k>", "<C-y>")
map("n", "<M-l>", "zl")
map("n", "<M-S-l>", "zL")
map("x", "<", "<gv")
map("x", ">", ">gv")
map({ "n", "x", "o" }, [[\]], "ge")
map({ "n", "x", "o" }, [[<C-\>]], "gE")
map({ "n", "x", "o" }, "H", "^")
map({ "n", "x", "o" }, "L", "g_")
map({ "n", "x", "o" }, "j", "gj")
map({ "n", "x", "o" }, "k", "gk")
map("n", "]t", "<Cmd>tabnext<CR>")
map("n", "[t", "<Cmd>tabprevious<CR>")
map(
    "n",
    "<Leader><Tab>",
    [[bufloaded(bufnr('#')) ? '<Cmd>b #<CR>' : exists(':BufferLineCyclePrev') == 2 ? '<Cmd>BufferLineCyclePrev<CR>' : '<Cmd>bp<CR>']],
    { expr = true, replace_keycodes = false }
)
map({ "n", "x" }, "<Leader>d", '"_d')
map("x", "<Leader>p", '"_dP')
map("n", "<Leader>x", function()
    require("cosmic.config.utils").buf_kill("bd", 0, true)
end)

local replace = function()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local prompt_default = string.gsub(vim.fn.getreg("/"), [[\V]], "")
    prompt_default = string.gsub(prompt_default, [[\<]], "")
    prompt_default = string.gsub(prompt_default, [[\>]], "")
    local popup_opts = {
        position = {
            row = 1,
            col = 0,
        },
        size = {
            width = #prompt_default > 25 and #prompt_default or 25,
            height = 2,
        },
        relative = "cursor",
        border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
                top = "[Replace]",
                top_align = "left",
            },
        },
    }
    local input_opts = {
        prompt = "> ",
        default_value = prompt_default,
        on_submit = function(input)
            if input then
                vim.cmd([[
                    function! Substitute()
                        let l:cur_pos = getcurpos()
                        if getregtype("s") != ""
                            let l:register = getreg("s")
                        endif
                        normal! qs
                        redir => l:replacements
                        try
                            execute ",$s//]] .. input .. [[/gce#"
                        catch /^Vim:Interrupt$/
                            return
                        finally
                            normal! q
                            let l:transcript = getreg("s")
                            if exists("l:register")
                                call setreg("s", l:register)
                            endif
                        endtry
                        redir END

                        if len(l:replacements) > 0
                            let l:last = strpart(l:transcript, len(l:transcript) - 1)
                            if l:last ==# "l" || l:last ==# "q" || l:last ==# "\<Esc>"
                                call setpos(".", l:cur_pos)
                                normal! zz
                                return
                            elseif l:last ==# "a"
                                silent! 1,''-&ge
                                call setpos(".", l:cur_pos)
                                normal! zz
                                return
                            endif
                        endif

                        if line("''") > 1
                            1,''-&gce
                            call setpos(".", l:cur_pos)
                            normal! zz
                        endif
                    endfunction
                    call Substitute()
                    delfunction! Substitute
                ]])
            end
        end,
    }

    local input = Input(popup_opts, input_opts)

    input:mount()

    input:map("i", { "<Esc>", "<C-c>" }, function()
        input.input_props.on_close()
    end, { noremap = true }, false)

    input:on(event.BufLeave, function()
        input:unmount()
    end)
end

vim.keymap.set("n", "<Leader>su", function()
    vim.schedule(function()
        vim.fn.setreg("/", vim.fn.expand("<cword>"))
        replace()
    end)
end)

vim.keymap.set("n", "<Leader>SU", function()
    vim.schedule(function()
        vim.fn.setreg("/", [[\<]] .. vim.fn.expand("<cword>") .. [[\>]])
        replace()
    end)
end)

vim.keymap.set("x", "<Leader>su", function()
    vim.fn.feedkeys("y", "")
    vim.schedule(function()
        vim.fn.setreg("/", vim.fn.getreg([["]]))
        replace()
    end)
end)

vim.keymap.set("x", "<Leader>SU", function()
    vim.fn.feedkeys("y", "")
    vim.schedule(function()
        vim.fn.setreg("/", [[\<]] .. vim.fn.getreg([["]]) .. [[\>]])
        replace()
    end)
end)
