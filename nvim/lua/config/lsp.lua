local utils = require('config.utils')

local M = {}

function M.config()
  local lspconfig = require('lspconfig')
  local lsp_status = require('lsp-status')
  lsp_status.register_progress()

  -- https://github.com/theia-ide/typescript-language-server
  lspconfig.tsserver.setup {
    on_attach = require('completion').on_attach 
  }
end

return M
