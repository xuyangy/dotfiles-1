local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
end

nvim_lsp.tsserver.setup{}
nvim_lsp.pyls.setup{}
nvim_lsp.vuels.setup{ 
  on_attach = on_attach,
  init_options = {
    config = {
      vetur = {
        completion = { autoImport = true, tagCasing = "initial" },
        languageFeatures = { codeActions = true, },
        validation = { templateProps = false, },
        experimental = { templateInterpolationService = true }
      }
    } 
  } 
} 

nvim_lsp.cssls.setup{}

nvim_lsp.diagnosticls.setup{
  filetypes = { "javascript", "typescript", "vue" },
  init_options = {
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      vue = "eslint",
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "eslint_d",
        rootPatterns = { ".eslintrc", ".eslintrc.json", ".eslintrc.cjs", ".eslintrc.js", ".eslintrc.yml", ".eslintrc.yaml", "package.json" },
        debounce = 100,
        args = {
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json",
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          security = "severity",
          message = "${message} [${ruleId}]",
        },
        securities = {
          ["1"] = "warning",
          ["2"] = "error",
        }
      },
    },
    formatters = {
      eslint_d = {
        command = "eslint_d",
        args = { "--stdin", "--fix-to-stdout", "--stdin-filename", "%filepath" },
        isStdout = true,
        doesWriteToFile = false,
      }
    },
    formatFiletypes = {
      javascript = "eslint_d",
      typescript = "eslint_d",
      vue = "eslint_d",
    }
  }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = true,
    signs = true,
    update_in_insert = true,
  }
)