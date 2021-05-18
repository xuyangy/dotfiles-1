vim.cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt=true }
  --lsp
  paq 'neovim/nvim-lspconfig'
  paq 'windwp/nvim-ts-autotag'

  --telescope & deps
  paq 'nvim-telescope/telescope.nvim'
    paq 'nvim-lua/popup.nvim' -- dep from readme 1
    paq 'nvim-lua/plenary.nvim' -- dep from readme 2
    paq 'kyazdani42/nvim-web-devicons'
    --paq { 'nvim-telescope/telescope-fzy-native.nvim', hook='git submodule update --init --recursive' } -- https://github.com/savq/paq-nvim/issues/6
    paq { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }

  --highlighting
  paq 'nvim-treesitter/nvim-treesitter'
  paq 'nvim-treesitter/playground'
  paq 'nvim-treesitter/nvim-treesitter-textobjects'
  paq 'ChristianChiarulli/nvcode-color-schemes.vim'
  --nvim misc
  paq 'lewis6991/gitsigns.nvim'
  paq 'hoob3rt/lualine.nvim'
  paq 'hrsh7th/nvim-compe'
  paq { 'lukas-reineke/indent-blankline.nvim', branch='lua' }
  --generic misc
  paq 'tpope/vim-fugitive'
  paq 'tpope/vim-surround'
  paq 'lambdalisue/suda.vim' --:SudaWrite
  paq 'windwp/nvim-autopairs' --autoinsert brackets
  paq 'kevinhwang91/rnvimr'  --file explorer
    vim.g.rnvimr_action = {
      ["<CR>"] = 'NvimEdit drop'
    }


local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist,
      },
    },
  },
  extensions = {
    fzf = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

require('telescope').load_extension('fzf')

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },
  ensure_installed = { "vue", "scss", "typescript", "javascript", "html", "lua"},
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"}
  },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = {
        ["]t"] = "function.outer",
        ["]k"] = "call.outer",
        ["]v"] = "parameter.outer",
      },
      goto_previous_start = {
        ["[t"] = "function.outer",
        ["[k"] = "call.outer",
        ["[v"] = "parameter.outer",
      }
    }
  }
}
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end


  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap("n", "<leader>fx", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  
  -- Set autocommands conditional on server_capabilities
  --[[
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]--, false)
  --]]
  --end
end

nvim_lsp.tsserver.setup{}
nvim_lsp.pyls.setup{}
nvim_lsp.vuels.setup{ 
  on_attach = on_attach,
  init_options = {
    config = {
      vetur = {
        completion = {
          autoImport = true,
          tagCasing = "initial"
        },
        languageFeatures = {
          codeActions = true,
        },
        validation = {
          templateProps = false,
        },
        experimental = {
          templateInterpolationService = true
        }
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

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    nvim_lsp = {priority = 1000};
    path = true;
    buffer = {priority = 10};
    nvim_lua = true;
    spell = true;
    tags = false;
    snippets_nvim = true; -- doesnt work because no snippet plugin
    treesitter = false;
    calc = false;
  };
}

--errors out in monorepo
--require('gitsigns').setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = true,
    signs = true,
    update_in_insert = true,
  }
)

require('lualine').setup{
  options = {
    theme = 'powerline',
  },
  sections = {
     lualine_a = {'mode'},
     lualine_b = {},
     lualine_c = {{'filename', path = 1},{'diagnostics', sources = {'nvim_lsp'}, color_error = "#ff0000"},'location', 'progress'},
     lualine_x = {},
     lualine_y = {'branch', 'diff'},
     lualine_z = {}
  },
  inactive_sections = {

     lualine_y = {'branch', 'diff'},
  }
}

require('nvim-autopairs').setup({})


require'lspinstall'.setup() -- important
