vim.opt.laststatus = 3

return {
  'nvim-lualine/lualine.nvim',
  opts = {
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
    },
    extensions = {
      'fugitive',
      'quickfix',
    },
  },
}
