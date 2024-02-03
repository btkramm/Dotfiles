return {
  'smoka7/hop.nvim',

  opts = {
    keys = 'etovxqpdygfblzhckisuran',

    quit_key = '<CR>',

    multi_windows = true,
  },

  keys = {
    {
      '<CR>',
      function()
        if vim.bo.buftype == 'quickfix' then
          if vim.fn.getqflist()[vim.fn.line('.')] then
            vim.cmd(string.format('cc %d', vim.fn.line('.')))
            vim.cmd.normal('zz')
          end
        else
          ---@diagnostic disable: missing-fields
          require('hop').hint_words({})
        end
      end,
      mode = { 'n', 'x' },
      desc = 'Hop - Toggle',
    },
  },
}
