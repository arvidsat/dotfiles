local utils = require('config.utils')

local M = {}

-- Server installation commands
-- npm install -g typescript-language-server
-- npm install -g intelephense

function M.config()
  local lspconfig = require('lspconfig')
  local lsp_status = require('lsp-status')
  lsp_status.register_progress()

  -- https://github.com/theia-ide/typescript-language-server
  lspconfig.tsserver.setup {}

  lspconfig.intelephense.setup{}
end

return M
