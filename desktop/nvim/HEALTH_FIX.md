# Checkhealth popravki (Arch Linux)

Ohranjen TokyoNight, lualine, cokeline, drevo datotek in Codex.

## Enkratni ukazi

```bash
sudo pacman -S --needed fd python-pynvim jdk21-openjdk composer
npm install -g neovim
# Po želji za Ruby / Perl / Julia podporo namesti ustrezna orodja; niso potrebna za tvoj stack.
```

`paq` je odstranjen iz Lazy konfiguracije. Če `:checkhealth lazy` še javlja star `paq` na runtimepath, preveri `:lua print(vim.inspect(vim.api.nvim_list_runtime_paths()))` in odstrani stare kopije iz `~/.local/share/nvim/site/pack/` (ne briši drugih pluginov na slepo).

Luarocks je izključen, ker noben trenutni plugin ne zahteva rocks. VimTeX se aktivira le, če sta nameščena `latexrun` in `sioyek`; LaTeX se zato ne nalaga na sistemu brez njiju. Stari colorizer je zamenjan z vzdrževanim NvChad fork-om.

Java: `jdtls` se zažene šele ob odprtju `.java` datoteke, zato ni na seznamu enabled LSP konfiguracij. Preveri z `nvim Main.java` in `:LspInfo`. Za JDTLS izberi JDK 21+ (`archlinux-java status`, po potrebi `sudo archlinux-java set java-21-openjdk`).

`c.doxygen` in `cpp.doxygen` opozorili prihajata iz clangd konfiguracije in običajno nista kritični.

Neobvezni opozorili: LuaSnip jsregexp (potrebno le za snippet transformacije), Perl/Ruby/Julia provider, BibTeX/Biber (le za LaTeX).

Po kopiranju konfiguracije: `:Lazy sync`, ponovno zaženi Neovim in `:checkhealth`.
