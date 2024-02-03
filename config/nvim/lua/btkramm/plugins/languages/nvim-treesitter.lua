return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',

  config = function()
    ---@diagnostic disable: missing-fields
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'all',

      highlight = { enable = true },

      indent = { enable = true },

      -- nvim-autopairs
      autopairs = { enable = true },

      -- nvim-ts-autotag
      autotag = { enable = false },
    })
  end,
}
