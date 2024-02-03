return {
  'pwntester/octo.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    enable_builtin = true,
    file_panel = { use_icons = false },
  },
  config = true,
  keys = {
    {
      '<leader>o',
      ':Octo<CR>',
      desc = 'Octo - Open',
    },
    {
      '#',
      '#<C-x><C-o>',
      mode = 'i',
      ft = 'octo',
    },
    {
      '@',
      '@<C-x><C-o>',
      mode = 'i',
      ft = 'octo',
    },
  },
}
