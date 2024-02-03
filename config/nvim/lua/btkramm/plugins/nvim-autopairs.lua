return {
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup({
      check_ts = true,
      disable_filetype = { 'TelescopePrompt', 'spectre_panel' }, -- :echo &ft
      fast_wrap = {
        chars = { '{', '[', '(', '"', '\'' },
        check_comma = true,
        end_key = '$',
        highlight = 'PmenuSel',
        highlight_grey = 'LineNr',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        map = '<M-e>',
        offset = 0,
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      },
      ts_config = {
        java = false,
        javascript = { 'string', 'template_string' },
        lua = { 'string', 'source' },
      },
    })
  end,
}
