return {
  'smoka7/hop.nvim',

  opts = {
    keys = 'etovxqpdygfblzhckisuran',

    quit_key = '<Tab>',

    multi_windows = true,
  },

  keys = {
    {
      '<Tab>',
      function()
        ---@diagnostic disable: missing-fields
        require('hop').hint_words({})
      end,
      mode = { 'n', 'v' },
      desc = 'Hop - Toggle',
    },
  },
}
