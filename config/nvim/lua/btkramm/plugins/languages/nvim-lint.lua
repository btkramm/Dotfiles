return {
  'mfussenegger/nvim-lint',

  config = function()
    local lint = require('lint')

    lint.linters.luacheck.args = { '--globals', 'vim' }

    lint.linters_by_ft = {
      lua = { 'luacheck' },
    }

    local lint_group = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({
      'BufEnter',
      'BufWritePost',
      'InsertLeave',
      'TextChanged',
    }, {
      group = lint_group,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
