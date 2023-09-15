local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    { "folke/neodev.nvim",  opts = {} },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'rose-pine/neovim',                        name = 'rose-pine' },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "rust", "javascript", "html",
                    "toml", "tsx" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    { "nvim-treesitter/nvim-treesitter-context", opts = {} },
    "nvim-treesitter/playground",
    "theprimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            -- from rust setup
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            -- engine
            {
                'L3MON4D3/LuaSnip',
                -- follow latest release.
                version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            },                   -- Required
        }
    },
    'mfussenegger/nvim-dap', -- DEBUGGING
    'simrat39/rust-tools.nvim',
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            char = '┊',
            --show_trailing_blankline_indent = false,
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                --add          = { text = '+' },
                --change       = { text = '~' },
                --delete       = { text = '_' },
                --topdelete    = { text = '‾' },
                --changedelete = { text = '~' },
                --untracked    = { text = '┆' },

                add = { text = "│", },
                change = { text = "│", },
                delete = { text = "", },
                topdelete = { text = "‾", },
                changedelete = { text = "~", },
                untracked = { text = "┆", },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>[h', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>]h', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },
    {
        'RRethy/nvim-base16'
    },
    {
        'nvim-lualine/lualine.nvim',
        -- Set lualine as statusline
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'rose-pine',
                --theme = 'base16',
                component_separators = '|',
                section_separators = '',
            },
        },
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {
            disable_filetype = { "TelescopePrompt", "vim" },
        } -- this is equalent to setup({}) function
    },
    {
        'windwp/nvim-ts-autotag',
        event = "InsertEnter",
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    'ThePrimeagen/git-worktree.nvim',
    {
        "petertriho/cmp-git",
        dependencies = "nvim-lua/plenary.nvim",
        ft = "gitcommit",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = true, bg = "#363B54" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = true, bg = "#363B54" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = true, bg = "#363B54" })
            --:hi IlluminatedWordText gui=underline guibg=
        end
    },
    {
        "RRethy/vim-illuminate",
        event = "BufEnter",
    },
})

-- vim.cmd('colorscheme rose-pine')
-- vim.cmd('colorscheme rose-pine')
