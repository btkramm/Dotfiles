return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('onedark').setup({
      lualine = { transparent = true },
      style = 'darker',
      transparent = true,
    })

    require('onedark').load()
  end,
  enabled = false,
}
