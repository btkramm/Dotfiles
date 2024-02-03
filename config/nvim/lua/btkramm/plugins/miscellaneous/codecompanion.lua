return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',

    'nvim-lua/plenary.nvim',

    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
  },

  config = true,

  opts = {
    adapters = {
      anthropic = function()
        return require('codecompanion.adapters').extend('anthropic', {
          env = { api_key = 'ANTHROPIC_API_KEY' },
        })
      end,
    },

    strategies = {
      chat = {
        adapter = 'anthropic',

        roles = { llm = 'AI', user = 'Me' },
      },
      inline = { adapter = 'anthropic' },
    },

    slash_commands = {
      ['buffer'] = {
        opts = { provider = 'telescope' },
      },
      ['file'] = {
        opts = { provider = 'telescope' },
      },
      ['help'] = {
        opts = { provider = 'telescope' },
      },
      ['symbols'] = {
        opts = { provider = 'telescope' },
      },
    },

    display = {
      chat = {
        window = { width = 0.25 },

        intro_message = 'Press ? for help',
      },
    },
  },

  keys = {
    { '<leader>a', ':CodeCompanionChat Toggle<CR>', desc = 'AI - Ask' },
    { '<leader>a', ':\'<,\'>CodeCompanionChat<CR>', mode = 'v', desc = 'AI - Ask' },

    {
      '<leader>e',
      function()
        vim.ui.input({ prompt = 'Edit' }, function(input)
          if input then
            vim.cmd('CodeCompanion ' .. input)
          end
        end)
      end,
      desc = 'AI - Edit',
    },
    {
      '<leader>e',
      function()
        vim.ui.input({ prompt = 'Edit' }, function(input)
          if input then
            vim.cmd('\'<,\'>CodeCompanion ' .. input)
          end
        end)
      end,
      mode = 'v',
      desc = 'AI - Edit',
    },
  },

  enabled = false,
}
