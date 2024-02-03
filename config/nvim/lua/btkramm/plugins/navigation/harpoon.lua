return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  branch = 'harpoon2',

  config = true,

  keys = {
    {
      '§',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon - Add',
    },
    {
      '<C-D-M-S-h>',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Harpoon - Select "h"',
    },
    {
      '<C-D-M-S-j>',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Harpoon - Select "j"',
    },
    {
      '<C-D-M-S-k>',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Harpoon - Select "k"',
    },
    {
      '<C-D-M-S-l>',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Harpoon - Select "l"',
    },
    {
      '<D-i>',
      function()
        local harpoon = require('harpoon')

        harpoon.ui:toggle_quick_menu(harpoon:list(), {
          border = 'rounded',

          title = ' Harpoon ',
          title_pos = 'center',

          ui_width_ratio = 0.45,
        })
      end,
      desc = 'Harpoon - Toggle',
    },
  },
}
