local M = {}

M.config = function()
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,
      custom_captures = {
        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
        ["S.connecting"] = "Identifier",
      },
    },
  }
end

return M
