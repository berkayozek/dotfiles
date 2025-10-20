return {
	name = "palantir-java-format",
	description = [[Palantir Java Formatter macOS native executable]],
	homepage = "https://github.com/palantir/palantir-java-format",
	licenses = { "Apache-2.0" },
	languages = { "Java" },
	categories = { "Formatter" },
	source = {
		id = "pkg:mason/palantir-java-format@2.80.0",
		---@async
		---@param ctx InstallContext
		install = function(ctx)
			local path = require("mason-core.path")
			local platform = require("mason-core.platform")

			local version = "2.80.0"
			local bin_asset = ("palantir-java-format-native-%s-nativeImage-macos_aarch64.bin"):format(version)
			local url = ("https://repo1.maven.org/maven2/com/palantir/javaformat/palantir-java-format-native/%s/%s"):format(
				version,
				bin_asset
			)

			-- download the binary (use curl -L to follow redirects)
			ctx.spawn.bash({
				"-c",
				("curl -fL -o %s %s"):format(bin_asset, url),
			})

			-- make it executable
			ctx.spawn.bash({
				"-c",
				("chmod +x %s"):format(bin_asset),
			})

            local canonical_name = "palantir-java-format"
            ctx.spawn.bash({
                "-c",
                ("mv %q %q"):format(bin_asset, canonical_name),
            })

            -- LINK THE BINARY SO MASON EXPOSES IT
            ctx:link_bin("palantir-java-format", canonical_name)
		end,
	},
}
