Paq'neovim/nvim-lspconfig'
Paq'kabouzeid/nvim-lspinstall'

-- turn on `window/workDoneProgress` capability

local vuels_config = {
  filetypes={"vue"},
  init_options = {
    config = {
      vetur = {
        -- its downright criminal that those are not enabled by default for vue
        completion = { autoImport = true, tagCasing = "initial" },
        languageFeatures = { codeActions = true, },
        experimental = { templateInterpolationService = true },
        --
        validation = { templateProps = false, },
        useWorkspaceDependencies = true,
      }
    }
  }
}

-- TODO: need to handle case when I attempt formatting but workspace folder has no eslint installed
local diagnosticls_config = {
  filetypes={"vue", "javascript", "typescript"},
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
        -- for some reason everyone has [1], [2] in their dotfiles on github
        -- but makes errors show up as warnings. you need to use ["1"] ["2"] instead
          ["1"] = "warning",
          ["2"] = "error",
        }
      },
    },
    formatters = {
      eslint_d = {
        command = "eslint_d",
        -- lots of args but thats because eslint_d refuses to lint .vue
        -- with with "regular" eslint_d args
        -- https://github.com/mantoni/eslint_d.js/issues/145
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

local luals_config = {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = {'vim', 'Paq', 'Keymap'} },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    }
  }
}

local lspinstall = require'lspinstall'
local nvim_lsp = require'lspconfig'

-- TODO: make this less stupid
local function setup_servers()
  lspinstall.setup{}
  local servers = lspinstall.installed_servers()
  for _, server in pairs(servers) do
    local config = {}
    if server == "vue" then
      config = vuels_config
    end
    if server == "diagnosticls" then
      config = diagnosticls_config
      config.filetypes = {"vue", "typescript", "javascript"}
    end
    if server == "lua" then
      config = luals_config
    end
    if server == "typescript" then
      config.filetypes = {"typescript", "javascript"}
    end
    nvim_lsp[server].setup(config)
  end
end

setup_servers()

--nvim_lsp.diagnosticls.setup(diagnosticls_config)

nvim_lsp.post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = true, -- works only on terminal emulators that support underlines (eg. kitty)
    signs = true,
    update_in_insert = true,
  }
)

