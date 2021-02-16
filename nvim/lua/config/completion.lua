local M = {}

function M.setup()
  vim.api.nvim_command("autocmd BufEnter * lua require'completion'.on_attach()")
  vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
end
return M
