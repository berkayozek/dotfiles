require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt" },
})

local Rule = require('nvim-autopairs.rule')
local npairs = require('nvim-autopairs')

npairs.add_rule(Rule('%"','%"',"remind"))
npairs.add_rule(Rule('/*','*/',"c"))
