vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

local java_cmds = vim.api.nvim_create_augroup("java_cmds", { clear = true })

local local_config = {}
pcall(function()
	local_config = require("local.java_config")
end)

-- Feature toggles
local features = {
	codelens = true,
	debugger = true,
}

local function get_jdtls_paths()
	local base = vim.fn.expand("$MASON/packages/jdtls")
	local path = {
		data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
		java_agent = base .. "/lombok.jar",
		launcher_jar = vim.fn.glob(base .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		platform_config = (function()
			if vim.fn.has("mac") == 1 then
				return base .. "/config_mac"
			end
			if vim.fn.has("unix") == 1 then
				return base .. "/config_linux"
			end
			if vim.fn.has("win32") == 1 then
				return base .. "/config_win"
			end
		end)(),
		bundles = {},
	}

	local function add_bundles(path_glob)
		local jars = vim.split(vim.fn.glob(path_glob), "\n", { trimempty = true })
		if #jars > 0 then
			vim.list_extend(path.bundles, jars)
		end
	end

	add_bundles(vim.fn.expand("$MASON/packages/java-test/extension/server/*.jar"))
	add_bundles(
		vim.fn.expand("$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
	)

	return path
end

local function enable_codelens(bufnr)
	pcall(vim.lsp.codelens.refresh)

	vim.api.nvim_create_autocmd("BufWritePost", {
		buffer = bufnr,
		group = java_cmds,
		desc = "refresh codelens",
		callback = function()
			pcall(vim.lsp.codelens.refresh)
		end,
	})
end

local function enable_debugger(bufnr)
	local jdtls = require("jdtls")
	jdtls.setup_dap({ hotcodereplace = "auto" })
	require("jdtls.dap").setup_dap_main_class_configs()

	vim.keymap.set("n", "<leader>df", function()
		jdtls.test_class()
	end, {
		buffer = bufnr,
		desc = "Debug: Test Class",
	})

	vim.keymap.set("n", "<leader>dn", function()
		jdtls.test_nearest_method()
	end, {
		buffer = bufnr,
		desc = "Debug: Test Nearest Method",
	})
end

local function jdtls_on_attach(_, bufnr)
	if features.debugger then
		enable_debugger(bufnr)
	end

	if features.codelens then
		enable_codelens(bufnr)
	end

	local jdtls = require("jdtls")

	vim.keymap.set({ "n", "x" }, "crv", function()
		jdtls.extract_variable(vim.fn.mode() == "v")
	end, { buffer = bufnr, desc = "Extract variable" })

	vim.keymap.set({ "n", "x" }, "crc", function()
		jdtls.extract_constant(vim.fn.mode() == "v")
	end, { buffer = bufnr, desc = "Extract constant" })

	vim.keymap.set("x", "crm", function()
		jdtls.extract_method(true)
	end, { buffer = bufnr, desc = "Extract method" })

	vim.keymap.set("n", "cro", function()
		jdtls.organize_imports()
	end, { buffer = bufnr, desc = "Organize imports" })
end

local function jdtls_setup()
	local jdtls = require("jdtls")
	local path = get_jdtls_paths()
	jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	local cmd = {
		"java",

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. path.java_agent,
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		path.launcher_jar,

		"-configuration",
		path.platform_config,

		"-data",
		path.data_dir,
	}

	local lsp_settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = path.runtimes,
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			format = {
				enabled = true,
			},
		},
		signatureHelp = {
			enabled = true,
		},
		completion = {},
		contentProvider = {
			preferred = "fernflower",
		},
		extendedClientCapabilities = jdtls.extendedClientCapabilities,
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
			useBlocks = true,
		},
	}

	local root_dir

	if local_config.root_dir then
		root_dir = local_config.root_dir
	else
		-- Your default configuration
		root_dir = vim.fs.dirname(
			vim.fs.find({ "pom.xml", "gradlew", "build.gradle", "settings.gradle", ".git" }, { upward = true })[1]
		)
	end

	jdtls.start_or_attach({
		cmd = cmd,
		settings = lsp_settings,
		on_attach = jdtls_on_attach,
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		root_dir = root_dir,
		flags = {
			allow_incremental_sync = true,
		},
		init_options = {
			bundles = path.bundles,
			extendedClientCapabilities = jdtls.extendedClientCapabilities,
		},
	})
end

jdtls_setup()
