function IncreaseWindowWidth()
  local current_width = vim.fn.winwidth(0)
  local new_width = current_width + math.floor(vim.fn.winwidth(0) / 2)

  -- Set the new window width
  vim.cmd("vertical resize " .. new_width)
end
function DecreaseWindowWidth()
  local current_width = vim.fn.winwidth(0)
  local new_width = current_width - math.floor(vim.fn.winwidth(0) / 2)

  -- Set the new window width
  vim.cmd("vertical resize " .. new_width)
end

function Setqflist_with_text()
  local qflist = vim.fn.getqflist()
  for _, entry in ipairs(qflist) do
    local bufnr = entry.bufnr
    local lnum = entry.lnum
    local line = vim.fn.getbufline(bufnr, lnum)[1]
    entry.text = line
  end
  vim.fn.setqflist(qflist)
end

