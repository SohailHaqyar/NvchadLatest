require "nvchad.mappings"
local map = vim.keymap.set
local nomap = vim.keymap.del
local allModes = {
  "n",
  "i",
  "v",
}

map(allModes, ";;", ":qa!<CR>")
map(allModes, "<C-u>", "<C-u>zz")
map(allModes, "<C-d>", "<C-d>zz")
map({ "n" }, "<leader>ts", "<cmd>silent !tmux neww darkseid<CR>")
map({ "n" }, "<leader>ss", "<cmd>silent !tmux neww tmux-switch-session.sh<CR>")
map({ "n" }, "<leader>cfn", "<cmd>silent !echo % | wl-copy <CR>")
map({ "n" }, "<leader>tt", function()
  require("base46").toggle_transparency()
end)

map({ "n", "i" }, "<C-f>", function()
  vim.diagnostic.open_float()
end)

nomap("n", "<leader>h")
nomap("n", "<A-i>")
nomap(allModes, "<C-s>")

local custom = {
  n = {
    ["<leader>ws"] = {
      "<cmd>w|source % <CR>",
      "Write & Source",
    },
    ["<leader>tn"] = {
      "<cmd>tabnew %<CR>",
      "Open current file in a new tab",
    },
    ["<leader>pr"] = {
      "<cmd>DiffviewOpen HEAD..origin/master<CR>",
      "Open Diffview with master",
    },
    ["<leader>l"] = {
      "<cmd>cn<CR>zz",
      "Quickfix Next",
    },
    ["<leader>h"] = {
      "<cmd>cp<CR>zz",
      "Quickfix Prev",
    },
    ["<C-u>"] = {
      "<C-u>zz",
      "Up & Center",
    },

    ["<C-d>"] = {
      "<C-d>zz",
      "Down & Center",
    },
    [";"] = {
      "<C-w>",
      "Manage windows",
    },
    ["<leader>gd"] = {
      function()
        vim.lsp.buf.definition()
        vim.cmd "tabnew %"
      end,
      "open definition in new tab",
    },
    ["<leader>+"] = {
      ":lua IncreaseWindowWidth()<CR>",
      "Increase width",
    },
    ["<leader>-"] = {
      ":lua DecreaseWindowWidth()<CR>",
      "Decrease width",
    },

    ["<leader>|"] = {
      "<C-w>|",
      "Maximize width",
    },

    ["<leader>="] = {
      "<C-w>=",
      "Equalize width",
    },
    --
    -- ["<C-n>"] = {
    --   "<cmd>Neotree<CR>",
    --   "Neo Tree",
    --
    -- },

    -- ["<C-n>"] = {
    --   "<cmd>:Ex<CR>",
    --   "Netrw File Explorer",
    -- },

    -- ["<leader>pv"] = {
    --   "<cmd>Triptych<CR>",
    --   "File Explorer",
    -- },
    ["<leader>gf"] = {
      "<C-w>vgf",
      "go to file",
    },
    ["<leader>e"] = {
      function()
        vim.cmd "silent! neovide ."
      end,
      "Neovide",
      opts = {
        nowait = true,
        silent = true,
      },
    },

    --
    [";;"] = {
      "<cmd>qa!<CR>",
      "Write and Quit All",
    },
    ["<leader>nde"] = {
      function()
        local null_ls = require "null-ls"
        null_ls.disable "eslint_d"
      end,
      "Disable Eslint Diagnostics",
    },
    ["<leader>nee"] = {
      function()
        local null_ls = require "null-ls"
        null_ls.enable "eslint_d"
      end,
      "Enable Eslint_d diganostics",
    },
    ["<leader>ndd"] = {
      function()
        local null_ls = require "null-ls"
        null_ls.disable "shellcheck"
      end,
      "Disable Shellcheck Diagnostics",
    },
    ["<leader>za"] = {
      function()
        local truzen = require "true-zen"
        truzen.ataraxis()
      end,
      "Toggle Atraaxis Mode",
    },
    ["<leader>zf"] = {
      function()
        require("true-zen").focus()
      end,
      "Toggle Focus Mode",
    },
    ["<leader>zm"] = {
      function()
        require("true-zen").minimalist()
      end,
      "Toggle Minimalist Mode",
    },
    ["<C-l>"] = {
      ":TmuxNavigateRight<CR>",
      "Move Right",
      opts = { nowait = true },
    },
    ["<C-h>"] = {
      ":TmuxNavigateLeft<CR>",
      "Move Left",
      opts = { nowait = true },
    },
    ["<C-k>"] = {
      ":TmuxNavigateUp<CR>",
      "Move Up",
      opts = { nowait = true },
    },
    ["<C-j>"] = {
      ":TmuxNavigateDown<CR>",
      "Move Down",
      opts = { nowait = true },
    },
    ["<leader>fs"] = {
      "<cmd> Telescope lsp_document_symbols <CR>",
      "Search current document symbols",
    },

    ["<leader>fas"] = {
      "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>",
      "Search workspace symbols ",
    },

    ["<leader>bda"] = {
      "<cmd>%bd|e#<CR>",
      "Delete all buffers except current",
    },

    ["<leader>td"] = {
      "<cmd>Trouble diagnostics<CR>",
      "Trouble diagnostics",
    },
    ["<leader>tc"] = {
      "<cmd>Trouble close<CR>",
      "Trouble close",
    },
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
    ["<leader>cq"] = {
      "<cmd>cclose<CR>",
      "close Quickfix",
    },

    ["<leader>rq"] = {
      function()
        Setqflist_with_text()
      end,
      "Quickfix Refresh",
    },
  },

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
}

map({ "n" }, ";", "<C-w>")
for _, keybindings in ipairs(custom) do
  for binding, mapping in pairs(keybindings) do
    map({ "n" }, binding, mapping[1], mapping.opts)
  end
end
