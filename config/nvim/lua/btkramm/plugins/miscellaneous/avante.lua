return {
  'btkramm/avante.nvim',
  branch = 'main',
  build = 'make',
  event = 'VeryLazy',
  lazy = false,

  opts = {
    behaviour = {
      auto_suggestions = false,

      auto_set_highlight_group = true,

      auto_set_keymaps = false,

      auto_apply_diff_after_generation = false,

      support_paste_from_clipboard = false,

      minimize_diff = true,
    },
    mappings = {
      submit = { insert = '<C-CR>', normal = '<CR>' },
      suggestion = { accept = '<M-Tab>', next = '<M-]>', prev = '<M-[>', reject = '<M-Esc>' },
    },
    windows = {
      sidebar_header = { enabled = false },
    },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',

    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',

    'stevearc/dressing.nvim',

    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },

  keys = {
    {
      '<leader>aa',
      function()
        require('avante.api').ask()
      end,
      mode = { 'n', 'v' },
      desc = 'Avante - Ask',
    },

    {
      '<leader>AA',
      function()
        local actions = {
          ['Improve code'] = 'Improve the following code',
          ['Add documentation'] = 'Add documentation to this code',
          ['Explain code'] = 'Explain what this code does',
          ['Optimize code'] = 'Optimize this code for better performance',
          ['Find bugs'] = 'Review this code and find potential bugs',
          ['Refactor code'] = 'Refactor this code to be more maintainable',
        }

        local _, start_row, start_col = unpack(vim.fn.getpos('v'))
        local _, end_row, end_col = unpack(vim.fn.getpos('.'))

        vim.ui.select(vim.tbl_keys(actions), {
          prompt = 'Ask',

          telescope = {
            theme = 'dropdown',

            layout_config = { width = 0.45, height = #vim.tbl_keys(actions) + 5 },
          },
        }, function(choice)
          if choice then
            vim.cmd('normal! ' .. start_row .. 'G' .. start_col .. '|')
            vim.cmd('normal! v')
            vim.cmd('normal! ' .. end_row .. 'G' .. end_col .. '|')

            require('avante.api').ask({ question = actions[choice] })
          end
        end)
      end,
      mode = { 'n', 'v' },
      desc = 'Avante - Ask from options',
    },

    {
      '<leader>ae',
      function()
        require('avante.api').edit()
      end,
      mode = { 'n', 'v' },
      desc = 'Avante - Edit',
    },
  },
}
