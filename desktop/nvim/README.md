# Neovim Config
Personal neovim config (lazy.nvim, Neovim 0.11+).

- Java: nvim-jdtls (ftplugin/java.lua) + jdtls/java-debug-adapter/java-test iz Masona
- C++: clangd (Mason), clang-format
- Formatiranje: conform.nvim (google-java-format za Java), `<leader>ff` ali samodejno ob shranjevanju
- LSP bližnjice: after/plugin/lsp.lua

## Codex + dodatni jeziki (Arch Linux)

1. Naredi backup: `cp -a ~/.config/nvim ~/.config/nvim.backup`
2. Razširi ZIP v `~/.config/` (mapa `nvim/` naj zamenja obstoječo; ne briši `~/.local/share/nvim`).
3. Namesti osnovo: `sudo pacman -S --needed neovim git nodejs npm jdk21-openjdk clang php composer`
4. Namesti Codex CLI: `npm install -g @openai/codex` (če npm nima pravic, uporabi uporabniški npm prefix ali upravljalnik Node različic).
5. Zaženi `codex login` in izberi prijavo s ChatGPT računom. Naročnina in omejitve Codex so odvisne od tvojega paketa.
6. Odpri `nvim`, nato `:Lazy sync` in `:Mason` ter počakaj, da se namestijo strežniki.
7. `<Ctrl-g>` odpre/zapre Codex v plavajočem terminalu. Zaženi Neovim v mapi projekta (`cd projekt && nvim .`), da Codex vidi projekt.
8. Za autocomplete začni tipkati; `Tab`/`Shift-Tab` izbira, `Enter` potrdi. `Ctrl-Space` ročno sproži predloge.
9. `:LspInfo` / `:checkhealth vim.lsp` preveri strežnike, `:ConformInfo` formatterje.

Jeziki: Java (jdtls), C/C++ (clangd), JavaScript/TypeScript (ts_ls), HTML (html), CSS (cssls), PHP (intelephense). Formatiranje: google-java-format, clang-format, prettier, php-cs-fixer.

**Opomba:** v originalu je bil tudi GitHub Copilot. Ta je odstranjen iz seznama pluginov, da se ne prekriva s Codexom. Codex v terminalu ni enak sprotnim AI predlogom med tipkanjem; slednje omogoča LSP/nvim-cmp.
