require("vid.remap")
require("vid.set")

-- Lazy Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-------------------------------------------------------------
	-- Style ----------------------------------------------------
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = { style = "night" },
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					disabled_filetypes = { "NvimTree", "packer" },
				},
			})
		end
	},

	-------------------------------------------------------------
	-- IDE ------------------------------------------------------
	{
		"danymat/neogen",
		config = true,
	},

	-------------------------------------------------------------
	-- Navigation -----------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},

	{
		"willothy/nvim-cokeline",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"stevearc/resession.nvim"
		},
		config = true
	},

	-------------------------------------------------------------
	-- Completion -----------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},

	-- Mason: namestitev LSP strežnikov, formatterjev, debuggerjev
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason poskrbi, da so vsa orodja res nameščena (jdtls, formatter, debug...)
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"jdtls",
					"java-debug-adapter",
					"java-test",
					"google-java-format",
					"clangd",       -- C++ LSP
					"clang-format", -- C++ formatter
					"typescript-language-server",
					"html-lsp",
					"css-lsp",
					"intelephense",
					"prettier",
					"php-cs-fixer",
				},
			})
		end,
	},

	-- mason-lspconfig (v2): samodejno vklopi nameščene strežnike (npr. clangd).
	-- jdtls izvzamemo, ker ga zažene nvim-jdtls (ftplugin/java.lua).
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = { exclude = { "jdtls" } },
			})
		end,
	},

	-- nvim-cmp: samodejno dokončevanje
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				completion = { autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged } },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- nvim-lspconfig: privzete nastavitve strežnikov (Neovim 0.11+ API)
	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			-- capabilities za vse strežnike (povezava z nvim-cmp)
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
			-- Java: jdtls zažene nvim-jdtls (ftplugin/java.lua)
			-- C++: clangd vklopi mason-lspconfig
		end,
	},

	-- Java: jdtls + debug + testi
	{
		"mfussenegger/nvim-jdtls",
		dependencies = { "mfussenegger/nvim-dap" },
	},

	-- Formatiranje (google-java-format za Java, clang-format za C++)
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					java = { "google-java-format" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					scss = { "prettier" },
					php = { "php_cs_fixer" },
				},
				-- JVM se zaganja počasi, zato velik timeout
				format_on_save = {
					timeout_ms = 5000,
					lsp_format = "fallback",
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>ff", function()
				require("conform").format({ async = false, timeout_ms = 5000, lsp_format = "fallback" })
			end, { desc = "Formatiraj datoteko" })
		end,
	},

	"mfussenegger/nvim-lint",
	-- Codex v terminalskem oknu Neovim (ChatGPT prijava prek Codex CLI)
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "float",
				float_opts = { border = "rounded" },
				shade_terminals = false,
			})
			local Terminal = require("toggleterm.terminal").Terminal
			local codex = Terminal:new({ cmd = "codex", hidden = true, direction = "float" })
			vim.keymap.set({ "n", "t" }, "<C-g>", function()
				codex:toggle()
			end, { desc = "Odpri/zapri Codex" })
		end,
	},

	-------------------------------------------------------------
	-- Writing --------------------------------------------------
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},

	{
		"lervag/vimtex",
		enabled = vim.fn.executable("latexrun") == 1 and vim.fn.executable("sioyek") == 1,
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "sioyek"
			vim.g.vimtex_compiler_method = "latexrun"
		end
	},

	"frabjous/knap",

	-------------------------------------------------------------
	-- Other ----------------------------------------------------
	"tpope/vim-fugitive",
	"mbbill/undotree",
	"andweeb/presence.nvim",
	"m4xshen/autoclose.nvim",
	"NvChad/nvim-colorizer.lua",
}, { rocks = { enabled = false } })

-- Samodejno osveževanje datotek, ki jih spremeni Codex
vim.opt.autoread = true

vim.api.nvim_create_autocmd({
	"FocusGained",
	"BufEnter",
	"CursorHold",
	"TermLeave",
}, {
	group = vim.api.nvim_create_augroup("CodexAutoReload", { clear = true }),
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("checktime")
		end
	end,
})


-- Load Plugins
require("autoclose").setup()
require("colorizer").setup({ user_default_options = { names = false } })
-- Theme configured in after/plugin/theme.lua.
