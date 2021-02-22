local M = {}

M.config = function()
  vim.g.coc_global_extensions = {
    'coc-tslint-plugin', 
    'coc-tsserver',
    'coc-emmet',
    'coc-css',
    'coc-html',
    'coc-json',
    'coc-yank',
    'coc-prettier'
  }
end

return M
