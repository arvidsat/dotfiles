local map = require('config.utils').map

local M = {}

local function setup()
  vim.g.ale_fixers = {
     ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
     javascript = {'prettier', 'eslint'},
  }
  -- vim.g.ale_fix_on_save = 1
  vim.g.ale_completion_enabled = 1
  vim.g.ale_completion_autoimport = 1


  map('n', '<leader>gd', ':AleGoToDefinition<cr>')
end

return M
