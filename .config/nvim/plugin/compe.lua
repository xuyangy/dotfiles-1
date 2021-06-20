_G.paq'hrsh7th/nvim-compe'
_G.paq 'onsails/lspkind-nvim'

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
    buffer = {priority = 10, kind = '🗑'};
    nvim_lua = true;
    spell = false;
    tags = false;
    snippets_nvim = true;
    treesitter = false;
    calc = false;
  };
  }

require('lspkind').init()
local npairs=require('nvim-autopairs')
-- skip it, if you use another global object
_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

require('nvim-autopairs').setup()

vim.api.nvim_set_keymap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

