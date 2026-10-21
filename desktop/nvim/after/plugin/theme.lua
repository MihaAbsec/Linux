require("tokyonight").setup({
  style = "night",
  on_colors = function(c)
    -- Keep Tokyo Night's syntax rules, with the desktop's Macchiato palette.
    c.bg = "#24273a"
    c.bg_dark = "#1e2030"
    c.bg_dark1 = "#181926"
    c.bg_float = "#1e2030"
    c.bg_sidebar = "#1e2030"
    c.bg_popup = "#1e2030"
    c.bg_statusline = "#1e2030"
    c.bg_highlight = "#363a4f"
    c.bg_visual = "#494d64"
    c.fg = "#cad3f5"
    c.fg_dark = "#a5adcb"
    c.fg_sidebar = "#a5adcb"
    c.fg_float = "#cad3f5"
    c.comment = "#8087a2"
    c.blue = "#8aadf4"
    c.purple = "#c6a0f6"
    c.magenta = "#c6a0f6"
    c.green = "#a6da95"
    c.yellow = "#eed49f"
    c.orange = "#f5a97f"
    c.red = "#ed8796"
    c.cyan = "#91d7e3"
    c.teal = "#8bd5ca"
    c.border = "#494d64"
    c.border_highlight = "#c6a0f6"
    c.error = "#ed8796"
    c.warning = "#eed49f"
  end,
})
vim.cmd[[colorscheme tokyonight]]
