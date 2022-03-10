local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")

local M = {}

M.snippets = {
	s({ trig = "print", name = "Print output" }, {
		c(1, {
			t("std::cout"),
			t("std::cerr"),
		}),
		t(" << "),
		i(0),
		t(";"),
	}),
}

M.map_snippets = function()
	ls.snippets.c = ls.snippets.cpp
	ls.snippets.h = ls.snippets.cpp
	ls.snippets.hpp = ls.snippets.cpp
	ls.snippets.tpp = ls.snippets.cpp
end

return M
