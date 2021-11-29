Paq'nvim-orgmode/orgmode'
Paq'akinsho/org-bullets.nvim'

require('orgmode').setup({
  org_agenda_files = {'~/Nextcloud/Notes/org/*'},
  org_default_notes_file = '~/Nextcloud/Notes/org/refile.org',
  org_agenda_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n%u'
    },
    j = {
      description = 'Journal entry',
      template = '* Journal %T %u\n%?',
      target = '~/Nextcloud/Notes/org/journal.org'
    } ,
    s = {
      description = 'Spanish word',
      template = '* %? - %T',
      target = '~/Nextcloud/Notes/org/spanish.org'
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
