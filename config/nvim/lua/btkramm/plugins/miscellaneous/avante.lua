return {
  'yetone/avante.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',

    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',

    'stevearc/dressing.nvim',

    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'Avante' },

      opts = {
        file_types = { 'Avante' },
      },
    },
  },
  build = 'make',
  lazy = false,

  opts = {
    behaviour = {
      auto_focus_sidebar = true,

      auto_suggestions = true,

      auto_set_highlight_group = true,

      auto_set_keymaps = true,

      auto_apply_diff_after_generation = false,

      support_paste_from_clipboard = false,

      minimize_diff = true,
    },
    mappings = {
      submit = { insert = '<C-CR>', normal = '<CR>' },
      suggestion = { accept = '<M-Tab>', next = '<M-]>', prev = '<M-[>', reject = '<M-Esc>' },
      sidebar = { close = 'q' },
    },
    windows = {
      sidebar_header = { enabled = false },
    },
  },

  keys = {
    {
      '<leader>aA',
      function()
        local actions = {
          ['Improve - Commit message'] = [[
Here is a commit message. Please improve it by:

- Find and fix all orthographic errors.
- Find and fix all grammar errors.
	
Please do not modify much of the structure of the commit message, but I allow
you to adjust it, focusing on its readability as the driving factor.	    
]],

          ['Improve - Orthography and grammar'] = [[
- Find and fix all orthographic errors.
- Find and fix all grammar errors.
]],
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
      desc = 'AI - Ask from options',
    },
  },
}
