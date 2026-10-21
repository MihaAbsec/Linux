local get_hex = require('cokeline.hlgroups').get_hl_attr

local yellow = vim.g.terminal_color_3

require('cokeline').setup({
  default_hl = {
    fg = function(buffer)
      return
        buffer.is_focused
        and get_hex('Normal', 'fg')
         or get_hex('Comment', 'fg')
    end,
    bg = function() return get_hex('ColorColumn', 'bg') end,
  },

  sidebar = {
    filetype = {'NvimTree', 'neo-tree'},
    components = {
      {
        text = function(buf)
          return buf.filetype
        end,
        fg = yellow,
        bg = function() return get_hex('NvimTreeNormal', 'bg') end,
        bold = true,
      },
    }
  },
})
