-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
--

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin",
  transparency = false,

  ---@diagnostic disable-next-line: missing-fields
  hl_override = {
    ["@comment"] = { italic = true },
    ["@keyword"] = { italic = true },
    ["@keyword.function"] = { italic = true },
    ["@keyword.return"] = { italic = true },
    ["@keyword.operator"] = { italic = true },
    ["@property"] = { italic = true },
    ["@type.builtin"] = { italic = true },
    ["@variable.builtin"] = { italic = true },
    ["@text.emphasis"] = { italic = true },
    ["@function.macro"] = { italic = true },
    ["@string"] = { italic = true },
  },
}
M.ui = {
  cmp = {
    style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
  },
  telescope = { style = "bordered" }, -- borderless / bordered
  statusline = {
    enabled = true,
    theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
  },

  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs" },
    modules = nil,
  },
}

M.mason = {
  pkgs = {
    "typescript-language-server",
    "rust-analyzer",
    "eslint_d",
    "eslint-lsp",
    "prettier",
    "prettierd",
    "stylua",
    "lua-language-server",
    "clangd",
    "gopls",
    "jsonls",
    "yamlls",
    "rust_analyzer",
  },
}
M.lsp = {
  signature = false,
}
return M
