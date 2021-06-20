Paq 'nvim-treesitter/nvim-treesitter'
Paq 'nvim-treesitter/playground'
Paq 'nvim-treesitter/nvim-treesitter-textobjects'
require'nvim-treesitter.configs'.setup {
  autotag = { enable = true },
  ensure_installed = { "vue", "scss", "typescript", "javascript", "html", "lua"},
  highlight = { enable = true, },
  indent = { enable = true },
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
