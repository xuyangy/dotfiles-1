Paq'neovim/nvim-lspconfig'
Paq'williamboman/nvim-lsp-installer'
Paq'nvim-lua/lsp_extensions.nvim'
Paq'b0o/schemastore.nvim'

-- vim.lsp.set_log_level 'trace'
require('vim.lsp.log').set_format_func(vim.inspect)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = true, -- works only on terminal emulators that support underlines (eg. kitty)
    signs = true,
    update_in_insert = true,
  }
)

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cl", "<Cmd>lua vim.lsp.codelens.run()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  --- custom
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><F12>', ':LspRestart<cr>:e<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>0", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>-", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)

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

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local nvim_lsp_installer = require('nvim-lsp-installer')

local lspinstaller_ensure_installed = function()
  local servers = {'jsonls', 'sumneko_lua', 'eslint', 'pyright'} -- omnisharp
  for _, name in pairs(servers) do
    local ok, server = nvim_lsp_installer.get_server(name)
    if ok and not server:is_installed() then
      server:install()
    end
  end
end
lspinstaller_ensure_installed()

nvim_lsp_installer.on_server_ready(function(server)
  local opts = {}
  if server.name == "sumneko_lua" then
    opts.settings = {
        Lua = {
          runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
          diagnostics = {
            globals = {
              'vim', 'Paq', 'inoremap', 'tnoremap', 'nnoremap', 'vnoremap'
            }
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      }
    }
    opts.on_attach = on_attach;
  elseif server.name == "ltex" then
    opts.filetypes = {'tex', 'bib'}
    opts.settings = {
      ltex = { language = 'pl-PL' }
    }
    opts.on_attach = on_attach;
  elseif server.name == "jsonls" then
    opts.settings = {
      json = { schemas = require('schemastore').json.schemas() }
    }
    opts.on_attach = on_attach;
  elseif server.name == "eslint" then
    opts.on_attach = function (client, bufnr)
      client.resolved_capabilities.document_formatting = true
      on_attach(client, bufnr)
    end
    opts.settings = {
      format = { enable = true },
    }
  end
  opts.capabilities = capabilities;
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end
)

local lspconfig = require'lspconfig'
require('sh_volar').register_volar_lspconfigs();
lspconfig.volar_api.setup{capabilities = capabilities, on_attach = on_attach}
lspconfig.volar_doc.setup{capabilities = capabilities, on_attach = on_attach}
lspconfig.volar_html.setup{capabilities = capabilities, on_attach = on_attach}


-- local lspconfig_util = require 'lspconfig.util'
-- local lspconfig_configs = require'lspconfig.configs'
-- lspconfig_configs.hellols = {
--   default_config = {
--     cmd = {'/home/artur/dev/hellols/target/debug/hellols'},
--     filetypes = { 'svelte'},
--     root_dir = lspconfig_util.root_pattern 'Cargo.toml'
--   },
-- }
--
-- lspconfig.hellols.setup{}
