return {
  'projekt0n/github-nvim-theme',
  lazy = false,
  priority = 1000,

  config = function()
    local theme = require('github-theme')

    theme.setup({
      options = { transparent = true },
    })

    vim.cmd('colorscheme github_dark_high_contrast')

    local C = require('github-theme.lib.color')
    local palette = require('github-theme.palette').load('github_dark_high_contrast')

    local BG = C.from_hex('#0A0C10')

    -- Git & Fugitive

    vim.api.nvim_set_hl(0, 'gitHash', { fg = '#DBB7FF' })

    vim.api.nvim_set_hl(0, 'fugitiveHash', { fg = '#DBB7FF' })

    vim.api.nvim_set_hl(0, 'Added', {
      bg = BG:blend(C(palette.scale.green[3]), 0.075):to_css(),
      fg = C(palette.scale.green[3]):to_css(),
    })

    vim.api.nvim_set_hl(0, 'Changed', {
      fg = C(palette.scale.yellow[6]):to_css(),
      bg = BG:blend(C(palette.scale.yellow[6]), 0.075):to_css(),
    })

    vim.api.nvim_set_hl(0, 'Removed', {
      fg = C(palette.scale.red[6]):to_css(),
      bg = BG:blend(C(palette.scale.red[6]), 0.075):to_css(),
    })
  end,

  enabled = true,
}
