syntax enable 
filetype plugin indent on
    
set termguicolors
set nocompatible rnu nu tabstop=2 shiftwidth=2 expandtab 
set ruler wildmenu noswapfile autoread
set ignorecase smartcase
set hidden
set completeopt=menuone,noselect

" https://vim.fandom.com/wiki/Highlight_current_line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

set shell=/bin/bash " zsh slow with vim-fugitive :Gstatus (on WSL)
set omnifunc=v:lua.vim.lsp.omnifunc "felt cute may delete later <C-x><C-o> remember
nnoremap <leader>fx mF:%!eslint_d --stdin --fix-to-stdout --stdin-filename %<CR>`F

nmap <leader>ll :lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>:edit<cr>

nmap <C-j> <C-w>w
nmap <C-k> <C-w>W
nmap <leader>q :q<cr>
nmap <leader>w :w<cr>
nmap <leader>ve :vsp $MYVIMRC<cr>
nmap <down> :cn<cr>
nmap <up> :cp<cr>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC " autoreload vimrc on save
autocmd FileType gitcommit exec 'au VimEnter * startinsert' 

" vim cursor shape not changing in tmux
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif

call plug#begin()
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/completion-nvim'
    set completeopt=menuone,noinsert,noselect
  Plug 'tjdevries/nlua.nvim'
  Plug 'tjdevries/lsp_extensions.nvim'
  Plug 'posva/vim-vue' " treesitter extension is unmaintained so I have to use this
    let g:vue_pre_processor = ['scss', 'typescript', 'javascript']

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'nvim-telescope/telescope.nvim'
    nnoremap <leader>ff <cmd>Telescope git_files<cr>
    nnoremap <leader>fF <cmd>Telescope find_files<cr>
    nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
    nnoremap <leader>fS <cmd>Telescope lsp_workspace_symbols<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>b <cmd>Telescope git_branches<cr>

  "misc
  Plug 'hrsh7th/nvim-compe'
    Plug 'hrsh7th/vim-vsnip'
    inoremap <silent><expr> <C-Space> compe#complete()
    inoremap <silent><expr> <CR>      compe#confirm('<CR>')
    inoremap <silent><expr> <C-e>     compe#close('<C-e>')
    inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
    inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
  Plug 'windwp/nvim-ts-autotag'
  Plug 'tpope/vim-fugitive'
    nmap <leader>s :G<CR>
    " don't ask to set upstream
    nmap <leader>ggp :G -c push.default=current push<CR> 
    nmap <leader>gL :G pull
    nmap <leader>gcb :G checkout origin/develop -b 
    nmap <leader>glo :G log<cr>
    nmap <leader>glO :G log %<cr>
    nmap <leader>gf :G fetch<cr>
  Plug 'kevinhwang91/rnvimr'
    nmap <leader>p :RnvimrToggle<cr>
    nmap <leader>P :RnvimrResize<cr>
    let g:rnvimr_enable_ex = 1
  Plug 'bkad/CamelCaseMotion'
   " https://github.com/bkad/CamelCaseMotion
   " nnoremap <Space> <NOP>
    map <silent> w <Plug>CamelCaseMotion_w
    map <silent> b <Plug>CamelCaseMotion_b
    sunmap w
    sunmap b

  Plug 'tpope/vim-surround'
  Plug 'jiangmiao/auto-pairs'
  Plug 'christianchiarulli/nvcode-color-schemes.vim'
  Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

colorscheme nvcode
hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#ff0000 guibg=#00ff00
hi User3 guifg=#0000ff guibg=#ffffff
hi User4 guifg=#00ff00 guibg=#222222
hi User5 guifg=#888888 guibg=#222222
hi StatusLine guifg=#0000ff guibg=#ffffff
hi StatusLineNC guifg=#eeeeee guibg=#222222
set statusline=\ %t\ \|\ 
set statusline+=%f\ 
set statusline+=%2*%m%*\ %3*%r%*\ %=\ 
set statusline+=%{fugitive#statusline()}

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    color_devicons = true,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.send_to_qflist
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    }
  }
}

require('telescope').load_extension('fzy_native')
EOF


lua << EOF
require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  },
  ensure_installed = { 'vue', 'javascript', 'typescript', 'json', 'python' },
  highlight = {
    enable = true,
  }
}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end


  require'completion'.on_attach()
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

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  
  -- Set autocommands conditional on server_capabilities
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
    ]], false)
  end
end


-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp.pyls.setup{}
nvim_lsp.vuels.setup{ 
  on_attach = on_attach,
  init_options = {
    config = {
      vetur = {
        validation = {
          templateProps = true
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
				command = "./node_modules/.bin/eslint_d",
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
					message = "${message} [${ruleId}]",
					security = "severity",
				},
				securities = {
					[2] = "error",
					[1] = "warning"
				}
			},
		}
	}
}
EOF

lua << EOF
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
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}

EOF

highlight Normal ctermbg=black
highlight Normal guibg=black
