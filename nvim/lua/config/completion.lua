local M = {}

function M.setup()
  vim.g.completion_matching_strategy_list = { 'exact', 'substring', 'fuzzy' }
  vim.g.completion_timer_cycle = 80
end
return M
