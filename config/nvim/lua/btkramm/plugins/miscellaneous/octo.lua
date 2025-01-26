return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',

    'nvim-lua/plenary.nvim',
  },
  lazy = false,

  opts = {
    use_local_fs = true,

    enable_builtin = true,

    ssh_aliases = {
      ['github.com%-personal'] = 'github.com',
      ['github.com%-work'] = 'github.com',
    },

    timeout = 10000,

    file_panel = { use_icons = false },
  },

  keys = {
    { '<leader>o', ':Octo<CR>', desc = 'Octo - Open' },

    { '#', '#<C-x><C-o>', mode = 'i', ft = 'octo' },
    { '@', '@<C-x><C-o>', mode = 'i', ft = 'octo' },
  },
}
