local map = vim.keymap.set
return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		opts = require("configs.conform"),
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			disable_netrw = false,
			hijack_netrw = false,
			sync_root_with_cwd = true,
			view = {
				preserve_window_proportions = true,
				centralize_selection = true,
				adaptive_size = true,
				float = {
					enable = false,
					quit_on_focus_loss = true,
					open_win_config = {
						-- relative = "editor",
						border = "rounded",
						height = vim.api.nvim_win_get_height(0) - 1,
						width = vim.api.nvim_win_get_width(0) - 1,
						row = 12,
						col = 22,
					},
				},
			},

			renderer = {},
		},
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"angular",
				"typescript",
				"html",
				"css",
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		event = "BufEnter",
	},
	{
		"sindrets/diffview.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.configs.diffview")
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			use_diagnostic_signs = true,
		},
		event = "VeryLazy",
	},
	{ "kevinhwang91/nvim-bqf", event = "VeryLazy" },

	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
		enable = false,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.configs.harpoon")
		end,
		event = "BufEnter",
	},

	-- {
	-- 	"jedrzejboczar/possession.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("plugins.configs.session-manager")
	-- 		map({ "n", "i" }, "<C-v>", "<cmd>:PossessionLoad<CR>")
	-- 		map({ "n", "i" }, "<C-x>", "<cmd>:PossessionSave<CR>")
	-- 	end,
	-- 	event = "VeryLazy",
	-- },
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({})
			map({ "n" }, "<leader>ps", function()
				require("telescope").extensions.projects.projects({})
			end)
		end,
		event = "BufEnter",
	},
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			-- require("vim-matchup").setup()
		end,
		event = "BufEnter",
	},

	{
		"joeveiga/ng.nvim",
		event = "BufEnter",
		config = function()
			local opts = { noremap = true, silent = true }
			local ng = require("ng")
			vim.keymap.set("n", "<leader>at", function()
				ng.goto_template_for_component()
			end, opts)
			vim.keymap.set("n", "<leader>ac", function()
				ng.goto_component_with_template_file()
			end, opts)
			vim.keymap.set("n", "<leader>aT", ng.get_template_tcb, opts)
		end,
	},

	{
		"artemave/workspace-diagnostics.nvim",
		event = "VeryLazy",
	},
	{
		"windwp/nvim-ts-autotag",
		event = "BufEnter",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = true, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		"prichrd/netrw.nvim",
		event = "BufEnter",
		opts = {},
		config = function()
			require("netrw").setup({
				use_devicons = true,
			})
		end,
		enabled = true,
	},

	-- { "tpope/vim-fugitive", event = "BufEnter" },
	-- { "airblade/vim-gitgutter", event = "BufEnter" },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		lazy = false,
		config = function()
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			vim.opt.foldnestmax = 4

			-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
			vim.keymap.set("n", "K", function()
				local winid = require("ufo").peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)

			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			-- global handler
			-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
			-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
			require("ufo").setup({
				fold_virt_text_handler = handler,
			})
		end,
	},
	{
		"hedyhli/outline.nvim",
		config = function()
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

			require("outline").setup({})
		end,
		lazy = false,
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
		},

		config = function()
			require("windows").setup()
		end,
		lazy = false,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	-- {
	--   "mrcjkb/rustaceanvim",
	--   version = "^4",
	--   ft = { "rust" },
	--   dependencies = "neovim/nvim-lspconfig",
	--   config = function()
	--     require "custom.configs.rustaceanvim"
	--   end,
	-- },
	-- {
	--   "saecki/crates.nvim",
	--   ft = { "toml" },
	--   config = function(_, opts)
	--     local crates = require "crates"
	--     crates.setup(opts)
	--     require("cmp").setup.buffer {
	--       sources = { { name = "crates" } },
	--     }
	--     crates.show()
	--     require("core.utils").load_mappings "crates"
	--   end,
	-- },
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	-- {
	--   "hrsh7th/nvim-cmp",
	--   opts = function()
	--     local M = require "plugins.configs.cmp"
	--     M.completion.completeopt = "menu,menuone,noselect"
	--     M.mapping["<CR>"] = cmp.mapping.confirm {
	--       behavior = cmp.ConfirmBehavior.Insert,
	--       select = false,
	--     }
	--     table.insert(M.sources, { name = "crates" })
	--     return M
	--   end,
	-- },
	-- { "github/copilot.vim", lazy = false },
	{
		"kevinhwang91/rnvimr",
		lazy = false,
	},
	{
		"prichrd/netrw.nvim",
		opts = {},
		lazy = false,
		config = function()
			require("netrw").setup({
				use_devicons = true,
			})
		end,
	},
	-- {
	--   "nvim-neo-tree/neo-tree.nvim",
	--   branch = "v3.x",
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	--     "MunifTanjim/nui.nvim",
	--     "saifulapm/neotree-file-nesting-config", -- add plugin as dependency. no need any other config or setup call
	--   },
	--   opts = {},
	--   config = function()
	--     require "custom.configs.neo-tree"
	--   end,
	--   lazy = false,
	-- },
	{
		"s1n7ax/nvim-window-picker",
		name = "window-picker",
		event = "VeryLazy",
		version = "2.*",
		config = function()
			require("window-picker").setup()
		end,
	},
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
			vim.cmd("filetype plugin indent on")
		end,
		enabled = false,
	},
	{
		"theRealCarneiro/hyprland-vim-syntax",
		lazy = false,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			"nvim-telescope/telescope.nvim", -- optional
		},
		config = function()
			require("plugins.configs.neogit-config")
		end,
		cmd = "Neogit", -- Loads when command is used
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		init = function()
			require("mini.indentscope").setup()
		end,
	},

	{
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
		end,
		dependencies = {
			"tpope/vim-repeat",
		},
		event = "BufEnter",
		enabled = true,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension("file_browser")
			vim.keymap.set("n", "<leader>fe", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
		end,
		event = "VeryLazy",
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
		lazy = false,
	},
	{
		"kwkarlwang/bufjump.nvim",
		config = function()
			require("bufjump").setup({
				on_success = function()
					vim.cmd([[execute "normal! g`\"zz"]])
				end,
			})
			local opts = { silent = true, noremap = true }
			vim.api.nvim_set_keymap("n", "<A-o>", ":lua require('bufjump').backward()<cr>", opts)
			vim.api.nvim_set_keymap("n", "<A-i>", ":lua require('bufjump').forward()<cr>", opts)
			vim.api.nvim_set_keymap("n", "<A-o>", ":lua require('bufjump').backward_same_buf()<cr>", opts)
			vim.api.nvim_set_keymap("n", "<A-i>", ":lua require('bufjump').forward_same_buf()<cr>", opts)
		end,
		lazy = false,
	},
	-- {
	--   "nvim-neo-tree/neo-tree.nvim",
	--   branch = "v3.x",
	--   cmd = { "Neotree" },
	--   dependencies = {
	--     "nvim-lua/plenary.nvim",
	--     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	--     "MunifTanjim/nui.nvim",
	--     -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	--   },
	--   opts = function()
	--     return require "plugins.configs.neo-tree"
	--   end,
	-- },
	{
		"mistricky/codesnap.nvim",
		build = "make",
		keys = {
			{ "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
			{ "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
		},

		cmd = { "CodeSnapSave", "CodeSnap" },
		opts = {
			save_path = "~/Pictures/Screenshots/",
			has_breadcrumbs = true,
			-- bg_theme = "peach",
			watermark = "",
			code_font_family = "MonaspiceRn NFM",
		},
	},
	-- tailwind-tools.lua
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
    lazy = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
		opts = {}, -- your configuration
	},
}
