-- Java: jdtls (nvim-jdtls) + debug + testi. Vse iz Masona.
local ok, jdtls = pcall(require, "jdtls")
if not ok then return end

local mason = vim.fn.stdpath("data") .. "/mason"
local jdtls_bin = mason .. "/bin/jdtls"
if vim.fn.executable(jdtls_bin) == 0 then
  vim.notify("jdtls ni nameščen (odpri :Mason ali počakaj na mason-tool-installer)", vim.log.levels.WARN)
  return
end

-- koren projekta (maven/gradle/git/src), sicer mapa datoteke
local root_dir = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", "build.gradle.kts", ".git", "src" })
  or vim.fn.expand("%:p:h")

-- vsak projekt dobi svoj workspace
local workspace = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- debug + test bundli
local bundles = {}
vim.list_extend(bundles, vim.fn.glob(
  mason .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true))
for _, jar in ipairs(vim.fn.glob(mason .. "/packages/java-test/extension/server/*.jar", true, true)) do
  local name = vim.fn.fnamemodify(jar, ":t")
  if name ~= "com.microsoft.java.test.runner-jar-with-dependencies.jar" and name ~= "jacocoagent.jar" then
    table.insert(bundles, jar)
  end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

jdtls.start_or_attach({
  cmd = { jdtls_bin, "-data", workspace },
  root_dir = root_dir,
  capabilities = capabilities,
  init_options = { bundles = bundles },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = { favoriteStaticMembers = {}, },
    },
  },
  on_attach = function(_, bufnr)
    local o = { buffer = bufnr }
    -- debug + testi (potrebuje nvim-dap)
    pcall(function()
      jdtls.setup_dap({ hotcodereplace = "auto" })
      require("jdtls.dap").setup_dap_main_class_configs()
    end)
    vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, o)
    vim.keymap.set("n", "<leader>tc", jdtls.test_class, o)
    vim.keymap.set("n", "<leader>tm", jdtls.test_nearest_method, o)
    vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, o)
    vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end, o)
    vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end, o)
    vim.keymap.set("n", "<leader>do", function() require("dap").step_over() end, o)
    vim.keymap.set("n", "<leader>dO", function() require("dap").step_out() end, o)
    vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, o)
  end,
})
