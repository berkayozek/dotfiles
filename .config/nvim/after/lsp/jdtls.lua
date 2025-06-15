local function get_mason_package_path(packageName)
	return vim.fn.expand("$MASON/share/" .. packageName)
end

local function get_jdtls_paths()
	local path = {}

	path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"

	local jdtls_install = get_mason_package_path("jdtls")

	path.java_agent = jdtls_install .. "/lombok.jar"
	path.launcher_jar = vim.fn.glob(jdtls_install .. "/plugins/org.eclipse.equinox.launcher_*.jar")

	if vim.fn.has("mac") == 1 then
		path.platform_config = vim.fn.expand("$MASON/packages/jdtls") .. "/config_mac"
	elseif vim.fn.has("unix") == 1 then
		path.platform_config = vim.fn.expand("$MASON/package/jdtls") .. "/config_linux"
	elseif vim.fn.has("win32") == 1 then
		path.platform_config = vim.fn.expand("$MASON/package/jdtls") .. "/config_win"
	end

	path.bundles = {}

	---
	-- Include java-test bundle if present
	---
	local java_test_path = get_mason_package_path("java-test")

	local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n")

	if java_test_bundle[1] ~= "" then
		vim.list_extend(path.bundles, java_test_bundle)
	end

	local java_debug_path = get_mason_package_path("java-debug-adapter")

	local java_debug_bundle =
		vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")

	if java_debug_bundle[1] ~= "" then
		vim.list_extend(path.bundles, java_debug_bundle)
	end

	return path
end

local path = get_jdtls_paths()
local data_dir = path.data_dir .. "/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local root_dir

local local_config = {} -- Initialize as an empty table

local status, result = pcall(require, "local.java_config") -- Store the result in a separate variable

if status then
	local_config = result -- Assign result to local_config if successful
end

if local_config.root_dir then
	root_dir = local_config.root_dir
else
	-- Your default configuration
	root_dir = vim.fs.dirname(
		vim.fs.find({ "pom.xml", "gradlew", "build.gradle", "settings.gradle", ".git" }, { upward = true })[1]
	)
end

local home = os.getenv("HOME")
local workspace_path = home .. "/.cache/jdtls/workspace/"
local os_name = "mac" -- `linux`, `win` or `mac`
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = workspace_path .. project_name

return {
	cmd = {
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
		home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. os_name,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	settings = {
		java = {
			import = {
				gradle = {
					enabled = true,
				},
				maven = {
					enabled = true,
				},
			},
		},
	},
}
