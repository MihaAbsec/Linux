#!/usr/bin/env bash
set -euo pipefail
style_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ $EUID -ne 0 ]]; then
    exec sudo bash "$style_dir/install.sh"
fi
backup_dir="/etc/lightdm/miha-style-backup-$(date +%Y%m%d-%H%M%S)"
install -d -m 755 "$backup_dir"
cp -a /etc/lightdm/lightdm-gtk-greeter.conf "$backup_dir/"
install -d -m 755 /usr/share/themes/Miha-Lock/gtk-3.0 /usr/share/backgrounds/miha-lock
install -m 644 "$style_dir/Miha-Lock/gtk-3.0/gtk.css" /usr/share/themes/Miha-Lock/gtk-3.0/gtk.css
install -m 644 "$style_dir/login.png" /usr/share/backgrounds/miha-lock/login.png
install -m 644 "$style_dir/greeter.conf" /etc/lightdm/lightdm-gtk-greeter.conf
echo "Prijavni zaslon je nastavljen. Sprememba bo vidna ob naslednji prijavi."
echo "Varnostna kopija: $backup_dir"
