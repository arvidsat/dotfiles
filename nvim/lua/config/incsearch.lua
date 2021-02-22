local map = require('config.utils').map

local M = {}

M.setup = function()
  print('incsearch setup')
  map('n', '\\/', '<Plug>(incsearch-forward)')
  map('n', '\\?', '<Plug>(incsearch-backward)')
  map('n', 'g\\/','<Plug>(incsearch-stay)')
end

return M
