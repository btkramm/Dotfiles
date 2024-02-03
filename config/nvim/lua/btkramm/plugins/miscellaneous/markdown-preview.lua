return {
  'iamcco/markdown-preview.nvim',
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  ft = { 'markdown' },
  cmd = { 'MarkdownPreview', 'MarkdownPreviewStop', 'MarkdownPreviewToggle' },
  keys = {
    { '<leader>c', ':MarkdownPreviewToggle<CR>', ft = 'markdown', desc = 'Markdown Preview - Close' },
    { '<leader>o', ':MarkdownPreviewToggle<CR>', ft = 'markdown', desc = 'Markdown Preview - Open' },
    { '<leader>t', ':MarkdownPreviewToggle<CR>', ft = 'markdown', desc = 'Markdown Preview - Toggle' },
  },
}
