local q = require"vim.treesitter.query"

local function i(value)
    print(vim.inspect(value))
end

local bufnr = 4

local language_tree = vim.treesitter.get_parser(bufnr, 'java')
local syntax_tree = language_tree:parse()
local root = syntax_tree[1]:root()

local query = vim.treesitter.parse_query('java', [[
(method_declaration
    (modifiers
        (marker_annotation 
            name: (identifier) @annotation (#eq? @annotation "Test")))
    name: (identifier) @method (#offset! @method))
]])

for _, captures, metadata in query:iter_matches(root, bufnr) do
    i(q.get_node_text(captures[2], bufnr))
    i(metadata)
end
