return {
  'folke/which-key.nvim',
  event = 'VeryLazy',

  opts = {
    preset = 'helix',

    delay = function(ctx)
      return ctx.plugin and 0 or 1000
    end,

    plugins = {
      marks = false,
      registers = false,
      spelling = { enabled = false },
    },

    win = { title = false },

    icons = { mappings = false },
  },
}
