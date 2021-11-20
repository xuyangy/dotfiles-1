Paq'hrsh7th/cmp-nvim-lsp'
Paq'hrsh7th/cmp-buffer'
Paq'hrsh7th/cmp-path'
Paq'hrsh7th/cmp-cmdline'
Paq'hrsh7th/nvim-cmp'

Paq'hrsh7th/cmp-nvim-lua'

Paq'hrsh7th/cmp-vsnip'
Paq'hrsh7th/vim-vsnip'
Paq'onsails/lspkind-nvim'

local cmp = require'cmp'
local lspkind = require'lspkind'

vim.opt.completeopt='menuone,noinsert,noselect'
cmp.setup{
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
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources(
    {
      { name = 'nvim_lua'},
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'orgmode' },
    },
    { { name = 'path' } },
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
}

cmp.setup.cmdline(':', {
  sources = cmp.config.sources(
    { { name = 'path' } },
    { { name = 'cmdline' } }
  )
})

cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
local autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', autopairs.on_confirm_done({  map_char = { tex = '' } }))
