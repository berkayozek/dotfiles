local o = vim.o
local wo = vim.wo
local bo = vim.bo
local opt = vim.opt

o.termguicolors = true

-- copy indent on a new line
o.autoindent = true

-- Default number of spaces
o.expandtab = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4

-- Highlight current cursor line
opt.cursorline = true

-- keep 5 lines above/below
o.scrolloff = 5

opt.breakindent = true

opt.swapfile = false
opt.backup = false

-- wildignore
opt.wildignore = {
	"*.exe",
	"*.dll",
	"*.so",
	"*.o",
	"*.pyc",
	"*.jpg",
	"*.png",
	"*.gif",
	"*.svg",
	"*.ico",
	"*.db",
	"*.tgz",
	"*.tar.gz",
	"*.gz",
	"*.zip",
	"*.bin",
	"*.pptx",
	"*.xlsx",
	"*.docx",
	"*.pdf",
	"*.tmp",
	"*.wmv",
	"*.mkv",
	"*.mp4",
	"*.rmvb",
	"*.ttf",
	"*.ttc",
	"*.otf",
	"*.mp3",
	"*.aac",
}

-- use english for spellchecking, but don't spellcheck by default
wo.spell = true
bo.spelllang = "en_gb"
wo.spell = false

-- line numbers
o.number = true
o.relativenumber = true

-- lower case searches ignore case
o.ignorecase = true
o.smartcase = true

-- popup settings
o.pumheight = 20

-- Setting notify
local status, notify = pcall(require, "notify")
if status then
    vim.notify = notify
end

opt.updatetime = 50

opt.signcolumn = "yes"



