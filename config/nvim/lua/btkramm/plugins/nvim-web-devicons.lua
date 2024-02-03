return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    require('nvim-web-devicons').setup({
      color_icons = false,
      strict = true,
    })
  end,
  enabled = false,
}
