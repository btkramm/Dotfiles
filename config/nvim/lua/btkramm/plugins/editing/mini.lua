return {
  'echasnovski/mini.nvim',
  event = 'InsertEnter',

  config = function()
    require('mini.ai').setup({})
    require('mini.surround').setup({})
  end,
}
