

#### i3 WM Desktop:
- [i3 WM](https://i3wm.org/)
- [Polybar](https://github.com/polybar/polybar)
- [Rofi](https://github.com/davatorium/rofi)
- [Picom](https://github.com/yshui/picom)
- [Dunst](https://dunst-project.org/)

#### Terminal:
- zsh
- [kitty](https://sw.kovidgoyal.net/kitty/)
- [cava](https://github.com/karlstav/cava)

#### Fonts:
- [Jetbrains Nerd Font](https://www.nerdfonts.com/)

#### Desktop appearance and lock screen (2026-10-21)

The `desktop/` configs use a Catppuccin Macchiato palette with mauve accents:
i3, Polybar, Rofi, Dunst, GTK3/GTK4, CopyQ, Kitty and a customized Tokyo Night
Neovim theme. F12 toggles a persistent Kitty scratchpad terminal.

Restore the desired directories from `desktop/` into `~/.config/` (the existing
installer offers these directories). Install the applications and their
dependencies first, including `kitty`, `python`, `xss-lock`, `copyq`, `dunst`,
`rofi`, `polybar`, and Nerd Fonts with **Symbols Nerd Font Mono**.

- Wallpaper: copy `wallpapers/wallpaper.jpg` to `~/wallpapers/wallpaper.jpg`.
- Lock screen: install AUR `betterlockscreen` and allow `i3lock-color` to replace
  `i3lock`, then run `~/.config/i3/setup-lockscreen.sh`.
- GTK: `gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark` and
  `gsettings set org.gnome.desktop.interface color-scheme prefer-dark`.
  Reopen applications after restoring their CSS.
- CopyQ appearance: `copyq loadTheme "$HOME/.config/copyq/macchiato.ini"`.
  Only the appearance is stored here, not clipboard history.
- LightDM GTK greeter: run `~/.config/lightdm-style/install.sh`. It needs sudo,
  backs up the previous greeter config, and applies on the next login.
- Reload i3 with Mod+Shift+C, or restart i3 with Mod+Shift+R.

The LightDM files are a staged theme; `/etc/lightdm` is not copied automatically
by the regular desktop config installation.
