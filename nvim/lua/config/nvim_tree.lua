local utils = require('config.utils')

local M = {}

function M.setup()
  utils.map('n', '<C-b>', '<cmd>NvimTreeToggle<CR>')
  utils.map('n', '<leader>bf', '<cmd>NvimTreeFindFile<CR>')
end

return M
