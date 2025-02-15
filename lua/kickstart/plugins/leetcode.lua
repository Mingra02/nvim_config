return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html', -- if you have `nvim-treesitter` installed
  dependencies = {
    'nvim-telescope/telescope.nvim',
    --    'ibhagwan/fzf-lua',
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-notify',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    -- configuration goes here
    ---@type lc.lang
    lang = 'python3',
    theme = {
      -- ["alt"] = {
      --     bg = "#FFFFFF",
      -- },
      ['normal'] = {
        fg = '#b4cced',
      },
    },
  },
}
