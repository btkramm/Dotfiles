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
      defaults = {
        results_title = '',
      },
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
        fzf = {
          case_mode = 'smart_case',
          fuzzy = true,
          override_file_sorter = true,
          override_generic_sorter = true,
        },

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
    {
      '<D-o>',
      function()
        require('telescope.builtin').buffers({ initial_mode = 'normal' })
      end,
      desc = 'Telescope - Open Files',
    },

    {
      '<D-p>',
      function()
        require('telescope.builtin').find_files()
      end,
      desc = 'Telescope - Files',
    },

    {
      '<D-S-g>',
      function()
        require('telescope-live-grep-args.shortcuts').grep_word_under_cursor({ initial_mode = 'normal' })
      end,
      desc = 'Telescope - Grep - Word under cursor',
    },
    {
      '<D-S-g>',
      function()
        require('telescope-live-grep-args.shortcuts').grep_visual_selection({ initial_mode = 'normal' })
      end,
      mode = 'x',
      desc = 'Telescope - Grep - Visual selection',
    },
    {
      '<D-g>',
      function()
        require('telescope').extensions.live_grep_args.live_grep_args()
      end,
      desc = 'Telescope - Grep',
    },

    {
      '<D-S-c>',
      function()
        require('telescope.builtin').git_bcommits({ initial_mode = 'normal' })
      end,
      desc = 'Telescope - Buffer Git Commits',
    },
    {
      '<D-b>',
      require('telescope.builtin').git_branches,
      desc = 'Telescope - Git Branches',
    },
    {
      '<D-l>',
      function()
        require('telescope.builtin').git_commits({ initial_mode = 'normal' })
      end,
      desc = 'Telescope - Git Commits',
    },

    {
      '<D-f>',
      function()
        require('telescope.builtin').diagnostics({ initial_mode = 'normal' })
      end,
      desc = 'Telescope - LSP Diagnostics',
    },
    {
      'gd',
      function()
        require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' })
      end,
      desc = 'Telescope - LSP Definitions',
    },
    {
      'gi',
      function()
        require('telescope.builtin').lsp_implementations({ initial_mode = 'normal' })
      end,
      desc = 'Telescope - LSP Implementations',
    },
    {
      'gr',
      function()
        require('telescope.builtin').lsp_references({ initial_mode = 'normal' })
      end,
      desc = 'Telescope - LSP References',
    },
  },
}
