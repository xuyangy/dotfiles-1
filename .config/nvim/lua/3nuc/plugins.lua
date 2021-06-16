vim.cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt=true }
  --lsp
  paq 'neovim/nvim-lspconfig'
  paq 'hrsh7th/nvim-compe'
    paq 'onsails/lspkind-nvim'


  --telescope & deps
  paq 'nvim-telescope/telescope.nvim'
    paq 'nvim-lua/popup.nvim' -- dep from readme 1
    paq 'nvim-lua/plenary.nvim' -- dep from readme 2
    paq 'kyazdani42/nvim-web-devicons'
    paq { 'nvim-telescope/telescope-fzf-native.nvim', run='make' }


  --highlighting
  paq 'nvim-treesitter/nvim-treesitter'
  paq 'nvim-treesitter/playground'
  paq 'nvim-treesitter/nvim-treesitter-textobjects'


  --visual stuffs
  paq { 'lukas-reineke/indent-blankline.nvim', branch='lua' }
  paq 'hoob3rt/lualine.nvim'

  paq 'folke/tokyonight.nvim'


  --git
  paq 'tpope/vim-fugitive'
    paq 'tpope/vim-dispatch'


  paq 'windwp/nvim-ts-autotag'
  paq 'machakann/vim-sandwich'
    -- use vim-surround mappings
    vim.cmd('runtime macros/sandwich/keymap/surround.vim')
  paq 'windwp/nvim-autopairs' --autoinsert brackets

  paq 'lambdalisue/suda.vim' --:SudaWrite
  paq 'kevinhwang91/rnvimr'  --file explorer
    vim.g.rnvimr_action = {
      ["<CR>"] = 'NvimEdit drop',
      ["<F1>"] = 'NvimEdit quit',
      ['<C-t>'] = 'NvimEdit tabedit',      
      ['<C-x>'] = 'NvimEdit split',
      ['<C-v>'] = 'NvimEdit vsplit',
      ['<C-o>'] = 'NvimEdit drop',
      ['gw'] = 'JumpNvimCwd',
      ['yw'] = 'EmitRangerCwd'
    }
   vim.g.rnvimr_enable_ex = 1
   vim.g.rnvimr_enable_picker = 1

  paq 'akinsho/nvim-toggleterm.lua'
    require("toggleterm").setup{}

  paq 'mfussenegger/nvim-dap'
