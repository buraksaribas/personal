local home = os.getenv("HOME")
local root_markers = { "gradlew", "mvnw", ".git", "pom.xml" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local workspace_folder = home .. "/.local/share/nvim/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local function get_bundles()
	local bundles = {}

	-- Add java-debug-adapter JAR
	local debug_jar = vim.fn.glob(
		home
			.. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
	)
	if debug_jar ~= "" then
		table.insert(bundles, debug_jar)
	end

	-- Add java-test JARs - get all JAR files in the directory
	local test_jar_pattern = home .. "/.local/share/nvim/mason/packages/java-test/extension/server/*.jar"
	local test_jars = vim.split(vim.fn.glob(test_jar_pattern), "\n", { trimempty = true })

	for _, jar in ipairs(test_jars) do
		if jar ~= "" and vim.fn.filereadable(jar) == 1 then
			table.insert(bundles, jar)
		end
	end

	return bundles
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
	flags = {
		debounce_text_changes = 80,
	},
	root_dir = root_dir,
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			extendedClientCapabilities = extendedClientCapabilities,
			maven = {
				downloadSources = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
			format = {
				enabled = false,
				settings = {
					profile = "GoogleStyle",
				},
			},
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				filteredTypes = {
					"com.sun.*",
					"io.micrometer.shaded.*",
					"java.awt.*",
					"jdk.*",
					"sun.*",
				},
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				hashCodeEquals = {
					useJava7Objects = true,
				},
				useBlocks = true,
			},
			configuration = {
				runtimes = {
					{
						name = "JavaSE-17",
						path = home .. "/.local/share/mise/installs/java/temurin-17",
					},
					{
						name = "JavaSE-21",
						path = home .. "/.local/share/mise/installs/java/temurin-21",
					},
				},
			},
		},
	},
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		-- "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/plugins/lombok.jar",
		"-jar",
		vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		workspace_folder,
	},
	init_options = {
		bundles = get_bundles(),
	},
}

config.on_attach = function(client, bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end
	require("jdtls").setup_dap({ hotcodereplace = "auto" })

	local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
	if status_ok then
		jdtls_dap.setup_dap_main_class_configs()
	end

	local function safe_keymap(mode, lhs, rhs, opts)
		if vim.api.nvim_buf_is_valid(bufnr) then
			vim.keymap.set(mode, lhs, rhs, opts)
		end
	end

	safe_keymap("n", "<leader>jo", jdtls.organize_imports, { desc = "Organize imports", buffer = bufnr })
	safe_keymap("n", "<leader>jtc", jdtls.test_class, { desc = "Test class", buffer = bufnr })
	safe_keymap("n", "<leader>jtm", jdtls.test_nearest_method, { desc = "Test method", buffer = bufnr })
	safe_keymap("n", "<leader>jev", jdtls.extract_variable_all, { desc = "Extract variable", buffer = bufnr })
	safe_keymap(
		"v",
		"<leader>jem",
		[[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
		{ desc = "Extract method", buffer = bufnr }
	)
	safe_keymap("n", "<leader>jec", jdtls.extract_constant, { desc = "Extract constant", buffer = bufnr })
end

config.on_detach = function(client, bufnr)
	-- Clean up any remaining references
	if vim.api.nvim_buf_is_valid(bufnr) then
		-- Clear buffer-specific keymaps
		local keymaps_to_clear =
			{ "<leader>jo", "<leader>jtc", "<leader>jtm", "<leader>jev", "<leader>jem", "<leader>jec" }
		for _, keymap in ipairs(keymaps_to_clear) do
			pcall(vim.keymap.del, "n", keymap, { buffer = bufnr })
		end
		pcall(vim.keymap.del, "v", "<leader>jem", { buffer = bufnr })
	end
end

require("jdtls").start_or_attach(config)
