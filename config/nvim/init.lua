-- Leader

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, nowait = true, silent = true })

-- @start lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- @end lazy.nvim

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('lazy').setup('btkramm.plugins', {
  ui = { border = 'rounded' },
})

require('btkramm.core.options')
require('btkramm.core.keymaps')
require('btkramm.core.highlights')

require('btkramm.scripts')
