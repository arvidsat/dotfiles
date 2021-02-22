local utils = require('config.utils')

local M = {}

M.config = function()
  vim.g.startify_change_to_vcs_root = 1
  vim.g.startify_session_persistence = 1
  vim.g.startify_files_number = 5
  
  vim.g.startify_lists = {
    { type = 'dir', header = { '   Current directory ' .. vim.fn.getcwd() } },
    { type = 'files', header = { '   Recent files' } },
    { type = 'sessions', header = { '   Sessions' } },
    { type = 'bookmarks', header = { '   Bookmarks' } },
    { type = 'commands', header = { '   Commands' } },
  }

  -- not populating the command line until you press a button. Not sure why...
  utils.map('n', '<leader>ps', [[":SSave " . luaeval('require"config.utils".cwd_name()')]], { expr = true })
end

return M
