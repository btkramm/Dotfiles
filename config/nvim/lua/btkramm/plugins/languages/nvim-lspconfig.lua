return {
  'neovim/nvim-lspconfig',
  dependencies = { 'RRethy/vim-illuminate' },

  config = function()
    vim.diagnostic.config({
      float = { border = 'rounded', header = '' },
      virtual_text = true,
    })

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
    })

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Bash

    require('lspconfig').bashls.setup({ capabilities = capabilities })

    -- ESLint

    require('lspconfig').eslint.setup({
      capabilities = capabilities,

      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    })

    -- Lua

    require('lspconfig').lua_ls.setup({
      capabilities = capabilities,

      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })

    -- Stylelint

    require('lspconfig').stylelint_lsp.setup({ capabilities = capabilities })

    -- TypeScript

    require('lspconfig').ts_ls.setup({
      capabilities = capabilities,

      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    })

    -- Zig

    require('lspconfig').zls.setup({ capabilities = capabilities })

    -- Ruby

    require('lspconfig').ruby_lsp.setup({
      capabilities = capabilities,

      init_options = {
        formatter = 'standard',
        linters = { 'standard' },
      },
    })
  end,
}
