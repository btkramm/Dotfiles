vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
  end,
})
