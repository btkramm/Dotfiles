return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },

        css = { 'prettier' },
        graphql = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        yaml = { 'prettier' },

        lua = { 'stylua' },
      },
      format_on_save = {
        async = true,
        lsp_fallback = true,
      },
      log_level = vim.log.levels.DEBUG,
    })

    -- Keymaps

    vim.keymap.set({ 'n', 'v' }, '<D-f>', function()
      conform.format({
        async = true,
        lsp_fallback = true,
      })
    end)
  end,
}
