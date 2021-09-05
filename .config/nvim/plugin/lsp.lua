Paq'neovim/nvim-lspconfig'
Paq'kabouzeid/nvim-lspinstall'

local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

--  https://github.com/johnsoncodehk/volar/blob/master/packages/shared/src/types.ts#L5
local volar_init_options = {
  typescript = {
     serverPath = "/home/artur/.npm-global/lib/node_modules/typescript/lib/tsserverlibrary.js",
   },
   languageFeatures={
     references={ enabledInTsScript=true },
     definition=true,
     typeDefinition=true,
     callHierarchy=true,
     hover=true,
     rename=true,
     renameFileRefactoring=true,
     signatureHelp=true,
     completion={
       defaultTagNameCase='both',
       defaultAttrNameCase='kebabCase',
       getDocumentNameCasesRequest=false,
       getDocumentSelectionRequest=false,
     },
     documentHighlight=true,
     documentLink=true,
     codeLens={
       showReferencesNotification=false,
     },
     semanticTokens=true,
     codeAction=true,
     diagnostics=true,
     schemaRequestService=true,
   },
   documentFeatures={
     selectionRange=true,
     foldingRange=true,
     linkedEditingRange=true,
     documentSymbol=true,
     documentColor=true,
     documentFormatting={
       defaultPrintWidth=100,
       getDocumentPrintWidthRequest=false,
     },
   }
 }

-- https://github.com/johnsoncodehk/volar/blob/master/package.json#L59
local volar_settings = {
   ['volar-api' ]= {
     trace= { server= "off" },
   },
   ['volar-document']= {
     trace= { server= "off" },
   },
   ['volar-html' ]= {
     trace= { server= "off" },
   },
   volar= {
     codeLens= {
       references= false,
       pugTools= false,
       scriptSetupTools= false,
     },
     formatting= {
       printWidth= 100,
     },
     icon= {
       splitEditors= true,
       preview= false,
       finder= false,
     },
     lowPowerMode= false,
     autoCompleteRefs= true,
     tsPluginStatus= false,
     checkVueTscVersion= false,
     preferredTagNameCase= "auto",
     preferredAttrNameCase= "auto",
     preview= {
       port= 3333,
       backgroundColor= "fff",
       transparentGrid= false,
     }
   }
 }

configs['volar'] = {
  default_config = {
    -- TODO volar-server executable is non-standard. it works for me because I downloaded it from the aur - it's just a script that runs node_modules/@volar/server/out/index.js
    -- TODO see https://github.com/johnsoncodehk/volar/issues/458
    cmd = { 'volar-server', '--stdio' },
    filetypes = { 'vue' },
    root_dir = util.root_pattern('package.json'),
    init_options = volar_init_options,
    settings = volar_settings,
  },
  docs = {
    package_json = 'https://github.com/johnsoncodehk/volar/blob/master/packages/server/package.json',
    description =
[[
https://github.com/johnsoncodehk/volar/tree/master/packages/server
Vetur language server for Vue
Vetur can be installed via TODO
```sh
TODO
```
]],
  },
}

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
        ignoreProjectWarning = true
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
      --config = vuels_config
      goto continue
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
    ::continue::
  end
end

setup_servers()
nvim_lsp.volar.setup{}

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

--[[
require 'lspinstall/servers'.volar = {
  -- shamelessly stolen from https://github.com/mattn/vim-lsp-settings/blob/1fdda7d3493f086b5e28446f8daa6a9d6dc1325c/installer/install-volar.sh
  install_script = [[
    ! test -f package.json && npm init -y --scope=lspinstall || true
    npm install @volar/server@0.27.12-alpha.1
    npm install typescript@4.3 # volar doesn't work well with TS4.4
 add doublesquarebracket here ,
--  uninstall_script = nil
}
--]]
