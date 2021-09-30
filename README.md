# Neovim Treesitter Query

* Neovim Treesitter Playground
* Language Tree & Syntax Tree
* Parse Query, Predicates & Directives
* Captures and Matches

# Treesitter Playground

## How to install

[Nvim treesitter playground GitHub](https://github.com/nvim-treesitter/playground)

### Packer
* Put the following configuration to packer package list
* Close Neovim and reopen
* Run `:PackerInstall` and `:PackerCompile`

```lua
use {
    'nvim-treesitter/playground',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    cmd = 'TSPlaygroundToggle',
    config = function()
        R'nvim-treesitter.configs'.setup({})
    end,
}
```

# Language Tree & Syntax Tree

* Get language tree for a given buffer
```lua
local language_tree = vim.treesitter.get_parser(<bufnr>)
```
* Get build syntax tree
```lua
local syntax_tree = language_tree:parse()
```
* Root node of the syntax tree
```lua
local root = syntax_tree[1]:root()
```

# Parse Query, Predicates & Directives

## Help
* `:h lua-treesitter-query`
* `:h parse_query`
* `:h lua-treesitter-predicates`
* `:h lua-treesitter-directives`


## Create a query

```lua
local query = vim.treesitter.parse_query( 'java', '(method_declaration)')

for id, match, metadata in query:iter_matches(root, <bufnr>, root:start(), root:end_()) do
    print(vim.inspect(getmetatable(match[1])))
end
```

## Create a capture

```lua
local query = vim.treesitter.parse_query('java', '(method_declaration) @method')
```

## Add predicate

```lua
local query = vim.treesitter.parse_query( 'java', [[
(method_declaration
  (modifiers
    (marker_annotation
      name: (identifier) @annotation (#eq? @annotation "Test"))))
]])
```

## Get node text

```lua
local q = R 'vim.treesitter.query'

local query = vim.treesitter.parse_query( 'java', [[
(method_declaration
  (modifiers
    (marker_annotation
      name: (identifier) @annotation (#eq? @annotation "Test")))
  name: (identifier) @method-name)
]])

for id, match, metadata in query:iter_matches(root, <bufnr>, root:start(), root:end_()) do
    print(q.get_node_text(match[2], <bufnr>))
end
```

### Get offset of the node

```lua
local query = vim.treesitter.parse_query('java', [[
(method_declaration
  (modifiers
    (marker_annotation
      name: (identifier) @annotation (#eq? @annotation "Test")))
  name: (identifier) @method-name (#offset! @method-name))
]])

for id, match, metadata in query:iter_matches(root, <bufnr>, root:start(), root:end_()) do
    vim.inspect(metadata)
end
```
