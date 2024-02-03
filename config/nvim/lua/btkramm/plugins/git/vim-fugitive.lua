local function find_buffer_with_filetype(filetype)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == filetype then
      return buf
    end
  end

  return nil
end

local function focus_buffer(bufnr)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      vim.api.nvim_set_current_win(win)

      return true
    end
  end

  return false
end

return {
  'tpope/vim-fugitive',
  lazy = false,

  keys = {
    { '<leader>g', ':G<CR>', desc = 'Fugitive - Git status' },
    { '<leader>g', '<C-w>q', ft = 'fugitive', desc = 'Fugitive - Close Git status' },

    { '<leader>G', ':vertical G<CR>', desc = 'Fugitive - Git status (vertical)' },
    { '<leader>G', '<C-w>q', ft = 'fugitive', desc = 'Fugitive - Close Git status (vertical)' },

    {
      '<leader>l',
      function()
        local git_bufnr = find_buffer_with_filetype('git')

        if git_bufnr then
          focus_buffer(git_bufnr)
        else
          vim.cmd('G lg')
        end
      end,
      desc = 'Fugitive - Open Git log',
    },
    { '<leader>l', '<C-w>q', ft = 'git', desc = 'Fugitive - Close Git log' },

    {
      '<leader>L',
      function()
        local git_bufnr = find_buffer_with_filetype('git')

        if git_bufnr then
          focus_buffer(git_bufnr)
        else
          vim.cmd('vertical G lg')
        end
      end,
      desc = 'Fugitive - Open Git log (vertical)',
    },
    { '<leader>L', '<C-w>q', ft = 'git', desc = 'Fugitive - Close Git log (vertical)' },
  },
}
