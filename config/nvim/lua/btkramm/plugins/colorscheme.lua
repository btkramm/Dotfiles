return {
  'navarasu/onedark.nvim',
  config = function()
    vim.cmd('set termguicolors')

    local onedark = require('onedark')

    onedark.setup({
      style = 'darker',
      transparent = true,
    })

    onedark.load()
  end,
}
