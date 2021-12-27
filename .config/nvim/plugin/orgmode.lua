Paq'nvim-orgmode/orgmode'
Paq'akinsho/org-bullets.nvim'
Paq'dhruvasagar/vim-table-mode'

local org_root = '~/Nextcloud/Notes/org/'
require('orgmode').setup({
  org_agenda_files = {org_root .. '*'},
  org_default_notes_file = org_root .. 'refile.org',
  org_archive_location = org_root .. 'archive.org',
  org_agenda_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n%u'
    },
    j = {
      description = 'Journal entry',
      template = '* Journal %T %u\n%?',
      target = org_root .. 'journal.org'
    } ,
    s = {
      description = 'Spanish word',
      template = "* Word :drill:\n:PROPERTIES:\n:DRILL_CARD_TYPE: twosided\n:END:\n*** Es\n%?\n*** En\n*** Example\n",
      target = org_root .. 'spanish.org'
    },
    b = {
      description = 'Shopping list',
      template = '* TODO %? - %T',
      target = org_root .. 'shopping.org'
    },
  },
  org_indent_mode = 'noindent'
})

require('org-bullets').setup {
    symbols = { "◉", "○", "✸", "✿" }
}

vim.api.nvim_exec(
[[
  function! SetOrgSets()
    setlocal conceallevel=2
    setlocal concealcursor=nc
    setlocal nowrap
  endfunction
  autocmd FileType org call SetOrgSets()
]],
true)
