return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'moll/vim-bbye',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
        buffer_close_icon = '✗',
        close_icon = '✗',
        path_components = 1, -- Show only the file name without the directory
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = 'slant', -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        show_tab_indicators = false,
        indicator = {
          -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'none', -- Options: 'icon', 'underline', 'none'
        },
        icon_pinned = '󰐃',
        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15,
        sort_by = 'insert_at_end',
      },
      highlights = {
        separator = {
          fg = '#3E4451', -- Consistent separator color
          bg = 'NONE', -- Transparent background for separators
        },
        offset_separator = {
          fg = '#3E4451', -- Consistent offset separator color
          bg = 'NONE', -- Transparent background for offset separators
        },
        tab_separator = {
          fg = '#3E4451', -- Consistent tab separator color
          bg = 'NONE', -- Transparent background for tab separators
        },
        fill = {
          fg = '#5C6370', -- Subdued color for unselected tab text
          bg = '#3E4451', -- Transparent background for the fill area
        },
        background = {
          fg = '#5C6370', -- Subdued color for unselected tab text
          bg = 'NONE', -- Transparent background for unselected tabs
        },
        buffer_selected = {
          fg = '#FFFFFF', -- Bright text for the selected tab
          bg = '#282C34', -- Solid background for the selected tab
          bold = true, -- Bold text for emphasis
          italic = false, -- No italics
        },
        separator_selected = {
          fg = '#3E4451', -- Same separator color for consistency
          bg = '#282C34', -- Matches selected tab's background
        },
        tab_selected = {
          fg = '#FFFFFF', -- Bright text for the selected tab
          bg = '#282C34', -- Solid background for the selected tab
        },
        close_button_selected = {
          bg = '#282C34', -- Make the close button match the background
        },
      },
    }
  end,
}
