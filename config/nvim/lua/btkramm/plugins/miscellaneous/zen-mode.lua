return {
  'folke/zen-mode.nvim',

  keys = {
    {
      '<leader>z',
      function()
        vim.cmd('ZenMode')
      end,
      desc = 'ZenMode - Toggle',
    },
  },
}
