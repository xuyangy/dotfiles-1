syntax enable 
filetype plugin indent on
highlight LineNr ctermbg=NONE guibg=NONE
    
set termguicolors
set nocompatible rnu nu tabstop=2 shiftwidth=2 expandtab 
set ruler wildmenu noswapfile autoread
set ignorecase smartcase

set shell=/bin/bash " zsh slow with vim-fugitive :Gstatus (on WSL)
set omnifunc=v:lua.vim.lsp.omnifunc "felt cute may delete later <C-x><C-o> remember
nnoremap <leader>fx :!eslint_d --fix % <CR>

nmap <leader>ll :lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>:edit<cr>

nmap <C-j> <C-w>w
nmap <C-k> <C-w>W
nmap <leader>q :q<cr>
nmap <leader>w :w<cr>
nmap <leader>ve :vsp $MYVIMRC<cr>
nmap ]q :cn<cr>
nmap [q :cp<cr>
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

  Plug 'puremourning/vimspector'
  Plug 'szw/vim-maximizer'

  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
    nnoremap <leader>ff <cmd>Telescope git_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
    nnoremap <leader>fS <cmd>Telescope lsp_workspace_symbols<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap \b <cmd>Telescope git_branches<cr>
    Plug 'kyazdani42/nvim-web-devicons'

  "misc
  Plug 'tpope/vim-fugitive'
    nmap \s :G<CR>
    nmap <leader>gp :G -c push.default=current push<CR> " don't ask to set upstream
    nmap <leader>gl :Gpull
    nmap <leader>gcb :G checkout origin/develop -b 
    nmap <leader>go :Glog<cr>
    nmap <leader>gO :Glog %<cr>
  Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
    let g:ranger_replace_netrw = 1
    let g:ranger_map_keys = 0
    map <leader>p :RangerWorkingDirectory<CR>
  Plug 'bkad/CamelCaseMotion'
  Plug 'tpope/vim-surround'
  Plug 'christianchiarulli/nvcode-color-schemes.vim'
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
set statusline+=%4*%{fugitive#head()}

lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'vue', 'javascript', 'typescript', 'json' }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
-- local lspconfig = require'lspconfig'
-- lspconfig.vuels.setup{on_attach=require'completion'.on_attach}
-- lspconfig.tsserver.setup{}
-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- THIS IS CRITICAL OR ELSE TREESITTER DOESNT HIGHLIGHT
-- parser_config.typescript.used_by = "vue"
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

