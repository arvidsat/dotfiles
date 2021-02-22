local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.is_buffer_empty()
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

function M.has_width_gt(cols)
    return vim.fn.winwidth(0) / 2 > cols
end 

function M.add_to_table(value, str, sep)
    sep = sep or ","
    str = str or ""
    value = type(value) == "table" and table.concat(value, sep) or value
    return str ~= "" and table.concat({value, str}, sep) or value
end

function M.cwd_name()
  return vim.fn.getcwd():match([[[%w%.-_]+$]])
end

return M
