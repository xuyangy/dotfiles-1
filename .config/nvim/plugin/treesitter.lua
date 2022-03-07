Paq 'nvim-treesitter/nvim-treesitter'
Paq 'nvim-treesitter/playground'
Paq 'nvim-treesitter/nvim-treesitter-textobjects'
Paq 'nvim-treesitter/nvim-treesitter-refactor'
Paq 'p00f/nvim-ts-rainbow'

require'orgmode'.setup_ts_grammar()
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
  autotag = { enable = true },
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
    -- disable = {'org'},
    additional_vim_regex_highlighting = {'org'}
  },
  indent = {
    enable = true,
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
  refactor = {
    highlight_definitions = {
      enable = true,
    }
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

-- vim.cmd [[
--   set foldlevel=1000000
--   set foldmethod=expr
--   set foldexpr=nvim_treesitter#foldexpr()
-- ]]
