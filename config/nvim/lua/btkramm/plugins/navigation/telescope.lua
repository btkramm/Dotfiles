return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    'nvim-lua/plenary.nvim',
  },

  config = function()
    local telescope = require('telescope')
    local telescopeLiveGrepArgsActions = require('telescope-live-grep-args.actions')

    telescope.setup({
      defaults = { results_title = '' },
      pickers = {
        buffers = { preview_title = '', prompt_title = 'Open Files' },

        find_files = {
          preview_title = '',
          prompt_title = 'Files',

          hidden = true,

          file_ignore_patterns = { '^.git/' },
        },

        git_bcommits = { preview_title = '', prompt_title = 'Buffer Git Commits' },
        git_branches = { preview_title = '', prompt_title = 'Git Branches', show_remote_tracking_branches = false },
        git_commits = { preview_title = '', prompt_title = 'Git Commits' },

        diagnostics = { preview_title = '', prompt_title = 'LSP Diagnostics' },
        lsp_definitions = { preview_title = '', prompt_title = 'LSP Definitions' },
        lsp_implementations = { preview_title = '', prompt_title = 'LSP Implementations' },
        lsp_references = { preview_title = '', prompt_title = 'LSP References' },
      },
      extensions = {
        live_grep_args = {
          preview_title = '',
          prompt_title = 'Grep',

          file_ignore_patterns = { '^.git/', '%.lock$' },

          mappings = {
            ['i'] = { ['<C-q>'] = telescopeLiveGrepArgsActions.quote_prompt() },
            ['n'] = { ['q'] = telescopeLiveGrepArgsActions.quote_prompt() },
          },
        },
      },
    })

    telescope.load_extension('fzf')
    telescope.load_extension('live_grep_args')
  end,

  keys = {
    { '<D-o>', require('telescope.builtin').buffers, desc = 'Telescope - Open Files' },
    { '<D-p>', require('telescope.builtin').find_files, desc = 'Telescope - Files' },

    {
      '<D-S-g>',
      function()
        require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()
      end,
      desc = 'Telescope - Grep - Word under cursor',
    },
    {
      '<D-S-g>',
      function()
        require('telescope-live-grep-args.shortcuts').grep_visual_selection()
      end,
      mode = 'v',
      desc = 'Telescope - Grep - Visual selection',
    },
    {
      '<D-g>',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = 'Telescope - Grep',
    },

    { '<D-S-c>', require('telescope.builtin').git_bcommits, desc = 'Telescope - Buffer Git Commits' },
    { '<D-b>', require('telescope.builtin').git_branches, desc = 'Telescope - Git Branches' },
    { '<D-l>', require('telescope.builtin').git_commits, desc = 'Telescope - Git Commits' },

    { '<D-f>', require('telescope.builtin').diagnostics, desc = 'Telescope - LSP Diagnostics' },
    { 'gd', require('telescope.builtin').lsp_definitions, desc = 'Telescope - LSP Definitions' },
    { 'gi', require('telescope.builtin').lsp_implementations, desc = 'Telescope - LSP Implementations' },
    { 'gr', require('telescope.builtin').lsp_references, desc = 'Telescope - LSP References' },
  },
}
