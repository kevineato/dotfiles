local utils = {}

utils.buf_kill = function(kill_command, bufnr, swap, force)
	local bo = vim.bo
	local api = vim.api
	local alt_bufnr = vim.fn.bufnr("#")

	-- If buffer is modified and force isn't true, print error and abort
	if not force and bo[bufnr].modified then
		return api.nvim_err_writeln(
			string.format("No write since last change for buffer %d (set force to true to override)", bufnr)
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
		if swap and api.nvim_buf_is_valid(alt_bufnr) and bo[alt_bufnr].buflisted then
			vim.cmd(string.format("b %d", alt_bufnr))
		end
		vim.cmd(string.format("%s %d", kill_command, bufnr))
	end
end

utils.align_comment = function()
	local api = vim.api
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
			api.nvim_command(tostring(c_begin + 1) .. "," .. tostring(c_end - 1) .. tab_intro)
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
				api.nvim_command(tostring(p_begin) .. "," .. tostring(p_end) .. tab_param .. p_tail)
			else
				api.nvim_command(tostring(p_begin) .. "," .. tostring(p_end) .. tab_param .. [[\|\*\zs \?]] .. p_tail)
			end
		end
		if vim.fn.search("@return", "c", c_end) ~= 0 then
			local r_begin = api.nvim_win_get_cursor(0)[1]
			if r_begin ~= c_end - 1 then
				api.nvim_command(tostring(r_begin) .. "," .. tostring(c_end - 1) .. tab_ret)
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
			vim.lsp.util.apply_text_edits(edits, 0)
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

return utils
