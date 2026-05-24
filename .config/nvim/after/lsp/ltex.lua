-- Fix for ltex-ls 16.0.0 crashing on startup with newer JDKs.
-- LanguageTool's bundled grammar.xml exceeds the JDK default
-- `jdk.xml.totalEntitySizeLimit` of 100,000 chars (it's 100,009).
-- Setting it to 0 disables the limit. See lsp.log for the SAXParseException.
return {
	cmd_env = {
		JAVA_OPTS = "-Djdk.xml.totalEntitySizeLimit=0 -Djdk.xml.entityExpansionLimit=0 -Djdk.xml.maxGeneralEntitySizeLimit=0",
	},
}
