return {
  'stevearc/conform.nvim',

  config = function()
    local conform = require('conform')

    conform.setup({
      formatters = {
        shfmt = { args = { '-i', '2', '-bn', '-ci', '-kp', '-s', '-sr' } },
      },

      formatters_by_ft = {
        -- Prettier

        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },

        css = { 'prettierd' },
        html = { 'prettierd' },

        graphql = { 'prettierd' },

        json = { 'prettierd' },
        yaml = { 'prettierd' },

        markdown = { 'prettierd' },

        -- Stylua

        lua = { 'stylua' },

        -- shfmt

        sh = { 'shfmt' },
      },
      format_on_save = { lsp_format = 'fallback' },
    })
  end,
}
