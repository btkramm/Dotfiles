return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      pickers = {
        find_files = {
          hidden = true,
        },
        git_branches = {
          show_remote_tracking_branches = false,
        },
        live_grep = {
          additional_args = function()
            return { '--hidden' }
          end,
        },
      },
      extensions = {
        file_browser = {
          mappings = {
            ['i'] = {
              ['<A-c>'] = false,
              ['<A-d>'] = false,
              ['<A-m>'] = false,
              ['<A-r>'] = false,
              ['<A-y>'] = false,
              ['<C-e>'] = false,
              ['<C-f>'] = false,
              ['<C-g>'] = false,
              ['<C-h>'] = false,
              ['<C-o>'] = false,
              ['<C-s>'] = false,
              ['<C-t>'] = false,
              ['<C-w>'] = false,
            },
            ['n'] = {
              ['o'] = actions.select_default,
            },
          },
        },
        fzf = {
          fuzzy = true,
          override_file_sorter = true,
          override_generic_sorter = true,
          case_mode = 'smart_case',
        },
      },
    })

    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('fzf')
  end,
}
