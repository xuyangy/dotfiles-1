Paq'neovim/nvim-lspconfig'
Paq'kabouzeid/nvim-lspinstall'
Paq'nvim-lua/lsp_extensions.nvim'

local nvim_lsp = require'lspconfig'

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
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>l', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader><F12>', ':lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>:edit<cr>', opts)

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

end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}

local lspinstall = require'lspinstall'
local function setup_servers()
  lspinstall.setup{}
  local servers = lspinstall.installed_servers()
  table.insert(servers, "volar");
  for _, server in ipairs(servers) do
    local config = {}
    if server == "vue" then
      config = {
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
    elseif server == "lua" then
        config = {
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
      elseif server == "diagnosticls" then
        config = {
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
      end

      config.on_attach = on_attach;
      config.capabilities = capabilities;
      nvim_lsp[server].setup(config)

  end
end

setup_servers()

nvim_lsp.post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end

