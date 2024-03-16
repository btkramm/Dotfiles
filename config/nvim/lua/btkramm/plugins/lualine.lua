return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local noirbuddy_lualine = require('noirbuddy.plugins.lualine')

    require('lualine').setup({
      sections = {
        lualine_a = {},
        lualine_b = {
          'branch',
          { 'diff' },
          { 'diagnostics' },
        },
        lualine_c = {
          { 'filename', path = 1 },
        },
        lualine_x = {},
        lualine_y = {
          { 'location' },
        },
        lualine_z = { '' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          { 'filename' },
        },
        lualine_x = {},
        lualine_y = {
          { 'location' },
        },
        lualine_z = {},
      },
      options = {
        component_separators = '',
        section_separators = '',

        theme = noirbuddy_lualine.theme,
      },
    })
  end,
}
