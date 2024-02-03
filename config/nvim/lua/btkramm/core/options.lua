vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.updatetime = 300
vim.opt.wrap = false

vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'TelescopePromptBorder' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })

vim.api.nvim_set_hl(0, 'FloatTitle', { link = 'TelescopeTitle' })

vim.api.nvim_set_hl(0, 'NuiFloatBorder', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'NuiNormalFloat', { link = 'NormalFloat' })
