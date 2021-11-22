Paq'neovim/nvim-lspconfig'
Paq'williamboman/nvim-lsp-installer'
Paq'nvim-lua/lsp_extensions.nvim'


vim.lsp.set_log_level 'trace'
require('vim.lsp.log').set_format_func(vim.inspect)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = true, -- works only on terminal emulators that support underlines (eg. kitty)
    signs = true,
    update_in_insert = true,
  }
)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap("n", "<leader>cl", "<Cmd>lua vim.lsp.codelens.run()<CR>", opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader><F12>', ':LspRestart<cr>:e<cr>', opts)

   -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>0", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>-", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

  if client.resolved_capabilities.code_lens then
    vim.api.nvim_exec([[
    augroup lsp_code_lens
    autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
    augroup END
    ]], false
    )
  end

end

local lsp_installer = require'nvim-lsp-installer'
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lsp_installer.on_server_ready(function(server)
    local opts = {}
    if server.name == "vuels" then
      opts = {
        filetypes={}, --temproarily doesn't contain "vue" because I'm testing volar
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
  elseif server.name == "typescript" then
    opts = {
      filetypes = {} --disable because of volar
    }
  elseif server.name == "sumneko_lua" then
    opts = {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
          diagnostics = { globals = {'vim', 'Paq', 'inoremap', 'tnoremap', 'nnoremap', 'vnoremap'} },
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
  elseif server.name == "ltex" then
  opts = {
    filetypes = { 'tex' },
    settings = {
      ltex = {
        language = 'pl-PL'
      }
    }
  }
  elseif server.name == "jsonls" then
    opts = {
      settings = {
        json = {
          schemas = { -- just use SchemaStore.nvim cmon
            {
              fileMatch = {"package.json"},
              url = "https://json.schemastore.org/package.json"
            },
            {
              fileMatch = {"tsconfig*.json"},
              url = "https://json.schemastore.org/tsconfig.json"
            },
            {
              fileMatch = {
                ".prettierrc",
                ".prettierrc.json",
                "prettier.config.json"
              },
              url = "https://json.schemastore.org/prettierrc.json"
            },
            {
              fileMatch = {".eslintrc", ".eslintrc.json"},
              url = "https://json.schemastore.org/eslintrc.json"
            },
            {
              fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"},
              url = "https://json.schemastore.org/babelrc.json"
            },
            {
              fileMatch = {"lerna.json"},
              url = "https://json.schemastore.org/lerna.json"
            },
            {
              fileMatch = {"now.json", "vercel.json"},
              url = "https://json.schemastore.org/now.json"
            },
            {
              fileMatch = {
                ".stylelintrc",
                ".stylelintrc.json",
                "stylelint.config.json"
              },
              url = "http://json.schemastore.org/stylelintrc.json"
            }
          }
        }
      }
    }
  end
  opts.on_attach = on_attach;
  opts.capabilities = capabilities;
  if server.name ~= "volar" then
    server:setup(opts)
  end
  vim.cmd [[ do User LspAttachBuffers ]]
end
)

local lspconfig = require'lspconfig'
local lspconfig_configs = require'lspconfig/configs'
local lspconfig_util = require 'lspconfig/util'

local function on_new_config(new_config, new_root_dir)
  local function get_typescript_server_path(root_dir)
    local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
    return project_root and (lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js'))
      or ''
  end

  if
    new_config.init_options
    and new_config.init_options.typescript
    and new_config.init_options.typescript.serverPath == ''
  then
    new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
  end
end

local function volar_cmd_debug(port)
  local VOLAR_DEBUG = true;
  if VOLAR_DEBUG then
    return {'node', '--inspect=:' .. port, '/home/artur/dev/volar/packages/server/out/index.js', '--stdio'}
  end
  return {'volar-server', '--stdio'}
end
local volar_root_dir = lspconfig_util.root_pattern 'package.json'

-- many of those are defaults, I just want a full list
local settings = {
  volar = {
    codeLens = {
      scriptSetupTools = true,
      references = true,
      pugTools = true,
    },
    lowPowerMode = false,
    formatting = { printWidth = 100 },
    autoCompleteRefs = true,
    takeOverMode = {enabled = true}, -- default is "auto" which launches only when builtin vscode TS ext is enabled. wonder how that logic behaves in neovim where there's no such builtin TS ext
    completion = {
      preferredTagNameCase = 'pascal',
      preferredAttrNameCase = 'kebab',
      autoImportComponent = true,
    },
    preview = {
      port = 3333,
      backgroundColor = '#fff',
      transparentGrid = true,
    }

  },
  ['volar-api'] = {
    trace = {
      server = 'verbose'
    }
  },
  ['volar-document'] = {
    trace = {
      server = 'verbose'
    }
  },
  ['volar-html'] = {
    trace = {
      server = 'verbose'
    }
  },
}

local commands = {
  VolarHtmlToPug = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.html-to-pug',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarPugToHtml = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.pug-to-html',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarUseSetupSugar = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.use-setup-sugar',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarUnuseSetupSugar = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.unuse-setup-sugar',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarUseRefSugar = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.use-ref-sugar',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarUnuseRefSugar = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.unuse-ref-sugar',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarShowReferences = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.show-references',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarConvertToKebabCase = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.server.executeConvertToKebabCase',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarConvertToPascalCase = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.server.executeConvertToPascalCase',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
}

lspconfig_configs.volar_api = {
  default_config = {
    cmd = volar_cmd_debug('6009'),
    commands = commands,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'vue'},
    trace = 'verbose',
    -- If you want to use Volar's Take Over Mode (if you know, you know)
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
      typescript = {
        serverPath = ''
      },
      languageFeatures = {
        references = true,
        definition = true,
        typeDefinition = true,
        callHierarchy = true,
        hover = true,
        rename = true,
        renameFileRefactoring = true,
        signatureHelp = true,
        codeAction = true,
        workspaceSymbol = true,
        completion = {
          defaultTagNameCase = 'both',
          defaultAttrNameCase = 'kebabCase',
          getDocumentNameCasesRequest = false,
          getDocumentSelectionRequest = false,
        },
        schemaRequestService = true,
      }
    },
  }
}
lspconfig.volar_api.setup{settings = settings}

lspconfig_configs.volar_doc = {
  default_config = {
    cmd = volar_cmd_debug('6010'),
    -- commands = commands,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'vue'},
    trace = 'verbose',
    -- If you want to use Volar's Take Over Mode (if you know, you know):
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
      typescript = {
        serverPath = ''
      },
      languageFeatures = {
        documentHighlight = true,
        documentLink = true,
        codeLens = { showReferencesNotification = true},
        -- not supported - https://github.com/neovim/neovim/pull/14122
        semanticTokens = false,
        diagnostics = true,
        schemaRequestService = true,
      }
    },
  },
}
lspconfig.volar_doc.setup{settings = settings}

lspconfig_configs.volar_html = {
  default_config = {
    cmd = volar_cmd_debug('6011'),
    -- commands = commands,
    root_dir = volar_root_dir,
    on_new_config = on_new_config,
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'vue'},
    trace = 'verbose',
    -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    init_options = {
      typescript = {
        serverPath = ''
      },
      documentFeatures = {
        selectionRange = true,
        foldingRange = true,
        linkedEditingRange = true,
        documentSymbol = true,
        -- not supported - https://github.com/neovim/neovim/pull/13654
        documentColor = false,
        documentFormatting = {
          defaultPrintWidth = 100,
        },
      }
    },
  }
}
lspconfig.volar_html.setup{settings = settings}

lspconfig_configs.hellols = {
  default_config = {
    cmd = {'/home/artur/dev/hellols/target/debug/hellols'},
    filetypes = { 'svelte'},
    root_dir = lspconfig_util.root_pattern 'Cargo.toml'
  },
}

lspconfig.hellols.setup{}
