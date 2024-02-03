local wk = require('which-key')

local keymap = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', { noremap = true, nowait = true, silent = true }, opts or {})

  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Copying and pasting

keymap({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from clipboard' })
keymap({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to clipboard' })

keymap({ 'n', 'v' }, '<leader>f', ':let @+ = expand("%:p")<CR>', { desc = 'Copy full path' })
keymap({ 'n', 'v' }, '<leader>r', ':let @+ = fnamemodify(expand("%"), ":~:.")<CR>', { desc = 'Copy relative path' })

-- Horizontal and vertical movement

keymap({ 'n', 'v', 'o' }, 'H', '^', { desc = 'Line start' })
keymap({ 'n', 'v', 'o' }, 'L', 'g_', { desc = 'Line end' })

keymap('n', 'J', 'jzz', { desc = 'Line down and center' })
keymap('n', 'K', 'kzz', { desc = 'Line up and center' })

keymap('n', '{', '<C-u>zz', { desc = 'Page up and center' })
keymap('n', '}', '<C-d>zz', { desc = 'Page down and center' })

-- Indentation

keymap('v', '<', '<gv', { desc = 'Decrease indent' })
keymap('v', '>', '>gv', { desc = 'Increase indent' })

-- Jumping

keymap('n', '<C-i>', '<C-i>zz', { desc = 'Jump forward and center' })
keymap('n', '<C-o>', '<C-o>zz', { desc = 'Jump backward and center' })

-- LSP

keymap('n', 'gf', vim.diagnostic.open_float, { desc = 'LSP - Diagnostics' })
keymap('n', 'gh', vim.lsp.buf.hover, { desc = 'LSP - Hover' })

keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP - Rename' })

-- Searching

keymap('n', '#', '#zz', { desc = 'Search - Word under cursor backward' })
keymap('n', '*', '*zz', { desc = 'Search - Word under cursor forward' })

keymap('n', 'N', 'Nzz', { desc = 'Search - Previous result' })
keymap('n', 'n', 'nzz', { desc = 'Search - Next result' })

keymap('n', '<ESC>', ':noh<CR>', { desc = 'Search - Clear' })

-- Sorting

keymap('v', '<leader>s', ':sort<CR>', { desc = 'Sort' })

-- Windows

keymap('n', ',v', ':vsplit<CR><C-w>l', { desc = 'Split window vertically' })
keymap('n', ',x', ':split<CR><C-w>j', { desc = 'Split window' })

keymap('n', '<C-h>', '<C-w>h', { desc = 'Move cursor to the left window' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Move cursor to the window below' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Move cursor to the window above' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Move cursor to the right window window' })

keymap('n', '<C-n>', ':vertical resize -8<CR>', { desc = 'Make window narrower' })
keymap('n', '<C-s>', ':resize -8<CR>', { desc = 'Make window shorter' })
keymap('n', '<C-t>', ':resize +8<CR>', { desc = 'Make window taller' })
keymap('n', '<C-w>', ':vertical resize +8<CR>', { desc = 'Make window wider' })

-- Writing, quitting and reloading

keymap('n', '<leader>w', ':w<CR>', { desc = 'Write' })
keymap('n', '<leader>fw', ':w!<CR>', { desc = 'Write (force)' })

keymap('n', '<leader>W', ':wa<CR>', { desc = 'Write all' })
keymap('n', '<leader>fW', ':wa!<CR>', { desc = 'Write all (force)' })

keymap('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
keymap('n', '<leader>fq', ':q!<CR>', { desc = 'Quit (force)' })

keymap('n', '<leader>Q', ':qa<CR>', { desc = 'Quit all' })
keymap('n', '<leader>fQ', ':qa!<CR>', { desc = 'Quit all (force)' })

keymap('n', '<leader>e', ':e<CR>', { desc = 'Reload' })
keymap('n', '<leader>fe', ':e!<CR>', { desc = 'Reload (force)' })

-- miscellaneous/avante.lua

wk.add({
  { '<leader>aa', desc = 'AI - Ask', mode = { 'n', 'v' } },
  { '<leader>ae', desc = 'AI - Edit', mode = { 'v' } },

  { '<leader>ac', desc = 'AI - Toggle buffer' },
  { '<leader>as', desc = 'AI - Toggle suggestions' },
})

vim.keymap.del('n', '<leader>aR')
vim.keymap.del('n', '<leader>ad')
vim.keymap.del('n', '<leader>af')
vim.keymap.del('n', '<leader>ah')
vim.keymap.del('n', '<leader>ar')
vim.keymap.del('n', '<leader>at')
