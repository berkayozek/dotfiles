-- Plugins

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- General
    use 'lewis6991/impatient.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'
    use {
        'akinsho/bufferline.nvim', 
        tag = "v3.*", 
        requires = 'nvim-tree/nvim-web-devicons'
    }
    use 'tpope/vim-fugitive'
    use {
        'nvim-treesitter/nvim-treesitter', 
        run = ':TSUpdate'
    }
    use 'mhinz/vim-startify'
    use 'kurocode25/mdforvim'
--    use 'puremourning/vimspector'

    use 'nvim-tree/nvim-tree.lua'

    -- show git sign in the lines
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
    }
    
    -- Java 
    use 'mfussenegger/nvim-jdtls'   
    
    -- Autopairs
    use 'windwp/nvim-autopairs'

    -- Completion
    -- use {'neoclide/coc.nvim', branch = 'release'}
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }
   
    -- Theme
    use { 'catppuccin/nvim', as = 'catppuccin' }

    -- Display possible keybings
    use "folke/which-key.nvim"
    use "echasnovski/mini.nvim"

    -- Find files
     use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }

    -- Search word in normal mode
    use 'ggandor/leap.nvim'

    -- Move line up and down
    use 'matze/vim-move'

    -- Comment easily
    use 'numToStr/Comment.nvim'

    -- Highlight TODO, FIX, etc. and inspect all of them 
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    -- Function documentation creator
    use 'danymat/neogen'

    -- Obsedian Note taking
    use {
        "epwalsh/obsidian.nvim",
        tag = "*",  -- recommended, use latest release instead of latest commit
        requires = {
            "nvim-lua/plenary.nvim",
        }
    }

    -- Markdown view
    use {
        "OXY2DEV/markview.nvim",
        ft = "markdown",
        lazy = false,
        preview = {
            icon_provider = "mini"
        }

    }

    use "rcarriga/nvim-notify"

    use {
        "epwalsh/pomo.nvim",
        tag = "*",      
        requires = {
            "rcarriga/nvim-notify",
        }
    }

end)
