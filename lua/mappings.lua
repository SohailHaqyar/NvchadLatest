require("nvchad.mappings")
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
map({ "n" }, "<leader>mv", "<cmd>Markview<CR>")
map({ "n" }, "<leader>tt", function()
	require("base46").toggle_transparency()
end)

-- nomap(allModes, "<C-f>")
map({ "n", "i" }, "<C-f>", function()
	vim.diagnostic.open_float()
end)

nomap("n", "<leader>h")
nomap("n", "<A-i>")
nomap(allModes, "<C-s>")
map("n", "<leader>cq", "<cmd>cclose<CR>")
map({ "n" }, ";", "<C-w>")
map({ "n" }, "<leader>ws", "<cmd>w|source % <CR>")
map({ "n" }, "<leader>tn", "<cmd>tabnew %<CR>")
map({ "n" }, "<leader>pr", "<cmd>DiffviewOpen HEAD..origin/master<CR>")
map({ "n" }, "<leader>l", "<cmd>cn<CR>zz")
map({ "n" }, "<leader>h", "<cmd>cp<CR>zz")
map({ "n" }, "<C-u>", "<C-u>zz")
map({ "n" }, "<C-d>", "<C-d>zz")
map({ "n" }, "<leader>|", "<C-w>|")
map({ "n" }, "<leader>=", "<C-w>=")
map({ "n" }, "<leader>gf", "<C-w>vgf")
map({ "n" }, "<leader>fs", "<cmd> Telescope lsp_document_symbols <CR>")
map({ "n" }, "<leader>fas", "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>")
map({ "n" }, "<leader>bda", "<cmd>%bd|e#<CR>")
map({ "n" }, "<leader>td", "<cmd>Trouble diagnostics<CR>")
map(allModes, "<C-n>", "<cmd>Ex<CR>")
-- vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { noremap = true })
-- vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { noremap = true })
-- vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { noremap = true })
-- vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { noremap = true })
-- vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, { noremap = true })
-- vim.keymap.set("n", "<C-s>", nvim_tmux_nav.NvimTmuxNavigateNext, { noremap = true })
map("i", "<C-\\>", function()
	vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot Accept", noremap = true, silent = true })

map("i", "<C-l>", "<Plug>(copilot-accept-word)")
map("i", "<C-j>", "<Plug>(copilot-accept-line)")

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "solarized",
	-- group = ...,
	callback = function()
		vim.api.nvim_set_hl(0, "CopilotSuggestion", {
			fg = "#555555",
			ctermfg = 8,
			force = true,
		})
	end,
})

-- Go to definition in next window (or create one if needed)
vim.keymap.set("n", "<leader>gd", function()
	-- Get the number of windows
	local win_count = #vim.api.nvim_list_wins()

	-- If there's only one window, create a split
	if win_count == 1 then
		vim.cmd("vsplit")
	else
		-- Otherwise, move to the next window
		vim.cmd("wincmd w")
	end

	-- Go to definition
	vim.lsp.buf.definition()
end, { noremap = true, silent = true, desc = "Go to definition in next window" })
