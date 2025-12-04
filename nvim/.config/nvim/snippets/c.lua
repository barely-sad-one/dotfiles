local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function create_header_guard()
    local file_name = vim.fn.expand("%:t") or "FILE_NAME"
    file_name = file_name:match("^(.*)%..+$")
    return file_name:upper() .. "_HEADER_H_"
end

ls.add_snippets("c", {
    s("chead",
        fmt([[
            #ifndef {}
            #define {}

            {}

            #endif // {}
        ]], {
            f(create_header_guard),
            f(create_header_guard),
            i(0),
            f(create_header_guard),
        })
    ),
})
