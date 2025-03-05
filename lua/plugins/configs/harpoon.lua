local harpoon = require "harpoon"
local map = vim.keymap.set
local nomap = vim.keymap.del
local function errorHandler(err)
  -- Custom error handling logic
  print("Error occurred:", err)
  -- You can add stack traceback here if needed
  return err
end

harpoon:setup {
  menu = {
    width = vim.api.nvim_win_get_width(0) - 12,
  },
}

map("n", "<leader>a", function()
  harpoon:list():add()
end)
map("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map("n", "<leader>1", function()
  local success, result = xpcall(function()
    harpoon:list():select(1)
  end, errorHandler)
  if not success then
    -- Handle the error here
    print("Error during Harpoon selection:", result)
    -- You could also log the error, try an alternative action, etc.
  end
end)
map("n", "<leader>2", function()
  harpoon:list():select(2)
end)

map("n", "<leader>3", function()
  harpoon:list():select(3)
end)

map("n", "<leader>4", function()
  harpoon:list():select(4)
end)

map({ "n" }, "<leader>p", function()
  nomap("n", "<leader>p")
  harpoon:list():prev()
end)

map({ "n" }, "<leader>n", function()
  nomap("n", "<leader>n")
  harpoon:list():next()
end)
