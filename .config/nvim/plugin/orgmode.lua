Paq'nvim-orgmode/orgmode'
Paq'akinsho/org-bullets.nvim'
Paq'dhruvasagar/vim-table-mode'

local org_root = '~/org/'
require('orgmode').setup({
  org_agenda_files = {org_root .. '**/*'},
  org_default_notes_file = org_root .. 'refile.org',
  -- org_archive_location = ,
  org_agenda_templates = {
    t = {
      description = 'Task',
      template = '* TODO %?\n%u',
      headline = 'TODOs',
    },
    m = {
      description = 'Meeting',
      template = '* TODO %?\n%u',
      headline = 'Meetings',
    },
    j = {
      description = 'Journal entry',
      template = '* Journal %T %u\n%?',
      target = org_root .. 'journal.org'
    } ,
  },
})

-- require('org-bullets').setup {
--     symbols = { "◉", "○", "✸", "✿" }
-- }
--
-- vim.api.nvim_exec(
-- [[
--   function! SetOrgSets()
--     setlocal conceallevel=2
--     setlocal concealcursor=nc
--     setlocal nowrap
--   endfunction
--   autocmd FileType org call SetOrgSets()
-- ]],
-- true)
