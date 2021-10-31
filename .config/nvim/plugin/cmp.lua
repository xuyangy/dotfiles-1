Paq 'hrsh7th/nvim-cmp'
Paq 'hrsh7th/cmp-nvim-lsp'
Paq 'hrsh7th/cmp-buffer'
Paq 'hrsh7th/cmp-vsnip'
Paq 'hrsh7th/cmp-nvim-lua'
Paq 'hrsh7th/vim-vsnip'
Paq 'onsails/lspkind-nvim'

local cmp = require'cmp'
local lspkind = require'lspkind'

vim.opt.completeopt='menuone,noinsert,noselect'
cmp.setup({
  experimental = {
    native_menu = false,
    ghost_text = true
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lua'},
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    },
    {
      { name = 'buffer' } ,
    }
  ),

  formatting = {
    format = lspkind.cmp_format(
      {
        with_text = true,
        maxwidth = 50,
        menu = {
          buffer = "[buf]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[nvim]",
          path = "[path]",
          vsnip = "[vsnip]",
        }
      }
    )
  }
})