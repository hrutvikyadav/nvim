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
    { "folke/neodev.nvim",  opts = {},      ft = 'lua' },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'rose-pine/neovim',           name = 'rose-pine' },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "rust", "javascript", "html",
                    "toml", "tsx", "ocaml" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                --autotag = { enable = true }
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<C-Left>"
                    }
                },
            })
            vim.cmd([[
                set foldmethod=expr
                set foldexpr=nvim_treesitter#foldexpr()
                set nofoldenable                     " Disable folding at startup.
            ]])
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {},
        event = { 'BufReadPre', 'BufNewFile' },
    },
    { "nvim-treesitter/playground", cmd = 'TSPlaygroundToggle' },
    "theprimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    {
        'VonHeikemen/lsp-zero.nvim',
        event = {
            "BufEnter *.lua",
            "BufEnter *.go",
            "BufEnter *.rs",
            "BufEnter *.nix",
            "BufEnter *.c",
            "BufEnter *.ml",
            "BufEnter *.html",
            "BufEnter *.js",
            "BufEnter *.jsx",
            "BufEnter *.ts",
            "BufEnter *.tsx",
        },
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
                version = "2.*",    -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                event = 'InsertEnter',
                config = function() -- NOTE: move after/plugin/name.lua to hplugins/name.lua and require that below
                    require('hplugins.snippets')
                end
            }, -- Required
        },
        config = function()
            require('hplugins.lsp')
            vim.cmd('LspStart')
        end
    },
    { 'mfussenegger/nvim-dap',    enabled = false }, -- DEBUGGING
    { 'simrat39/rust-tools.nvim', event = 'BufEnter *.rs' },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        cmd = 'IBLToggle',
        opts = {
            -- char = '┊', `┋`,  `▏`, `│`
            indent = { char = "│" },
            --[[ indent = {
                char = "│",
                priority = 2,
            }, ]]
            -- whitespace = { highlight = { "DiagnosticError", "NonText" } },
            -- whitespace = { highlight = { "IndentGuideLight", "IndentGuideLight2", "IndentGuideDark" } }, -- Suited for light bg
            whitespace = { highlight = { "IndentGuideDark2", "NonText", "IndentGuideBlack" } }, -- Suited for transparent bg
            -- whitespace = { highlight = { "IndentGuideRed5", "IndentGuideRed6", "IndentGuideRed7" } }, -- shades of red
            scope = {
                show_start = false,
                show_end = false,
                highlight = {
                    "Function",
                    "Label",
                },
            }
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
                --                vim.keymap.set('n', '<leader>[h', require('gitsigns').prev_hunk,
                --                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                --                vim.keymap.set('n', '<leader>]h', require('gitsigns').next_hunk,
                --                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                --                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                --                    { buffer = bufnr, desc = '[P]review [H]unk' })
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true })

                -- Actions
                --map('n', '<leader>hs', gs.stage_hunk)
                --map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                --map('n', '<leader>hS', gs.stage_buffer)
                --map('n', '<leader>hu', gs.undo_stage_hunk)
                -- reset to current commit
                map('n', '<leader>hr', gs.reset_hunk)
                map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
                map('n', '<leader>hR', gs.reset_buffer)
                -- preview
                map('n', '<leader>hp', gs.preview_hunk)
                -- blame
                map('n', '<leader>hb', function() gs.blame_line { full = true } end)
                map('n', '<leader>tb', gs.toggle_current_line_blame)
                --diff
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>hD', function() gs.diffthis('~') end)
                --map('n', '<leader>td', gs.toggle_deleted)

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
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
        config = function()
            require('hplugins.ts-autotags')
        end
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
        config = function()
            require('cmp_git').setup() -- needed?
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
            --vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = false, bg = "#363B54" })
            --vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = false, bg = "#363B54" })
            --vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = false, bg = "#363B54" })
            --:hi IlluminatedWordText gui=underline guibg=
        end
    },
    {
        "RRethy/vim-illuminate",
        event = {
            "BufEnter *.lua",
            "BufEnter *.go",
            "BufEnter *.rs",
            "BufEnter *.nix",
            "BufEnter *.c",
            "BufEnter *.ml",
            "BufEnter *.html",
            "BufEnter *.js",
            "BufEnter *.jsx",
            "BufEnter *.ts",
            "BufEnter *.tsx",
        },
        config = function()
            require('illuminate').configure({
                filetype_denylist = {
                    'fugitive',
                    'help',
                    'gitcommit',
                    'fugitiveblame'
                }
            })
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { underline = false, bg = "#363B54" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underline = false, bg = "#363B54" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underline = false, bg = "#363B54" })
            --:hi IlluminatedWordText gui=underline guibg=
        end
    },
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        ft = { 'html', 'javascriptreact', 'typescriptreact' },
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    },
    'norcalli/nvim-colorizer.lua',
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('hplugins.treesitter-text-objects')
        end
    },
    {
        "folke/zen-mode.nvim",
        cmd = 'ZenMode',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function()
            require('hplugins.zenmode')
        end,
        dependencies = {
            "folke/twilight.nvim",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        }
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- FIX:
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- TODO: check if its working with treesitter textobjects
            -- add any options here
        },
        lazy = false,
    },
    {
        "karb94/neoscroll.nvim", -- INFO: cinnamon scroll as alternative
        enabled = false,
        event = 'VeryLazy',
        config = function()
            require('neoscroll').setup {
                mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb' }, -- '<C-y>', '<C-e>',
                post_hook = function()
                    vim.cmd('norm zz')
                end, -- Function to run after the scrolling animation ends
            }
        end
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
            require('rainbow-delimiters.setup').setup({
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                },
                --[[ highlight = {
                    -- 'RainbowDelimiterRed',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterBlue',
                    -- 'RainbowDelimiterYellow',
                    -- 'RainbowDelimiterOrange',
                    -- 'RainbowDelimiterCyan',
                } ]]
                highlight = {
                    -- 'RainbowDelimiterRPViolet',
                    "RainbowDelimiterRPPurple",
                    -- "RainbowDelimiterRPRed",
                    'RainbowDelimiterRPCyan',
                    'RainbowDelimiterBlue',
                }
            })
        end
    },
    {
        'eandrju/cellular-automaton.nvim',
        -- enabled = false,
        cmd = 'CellularAutomaton'
    },
    {
        'declancm/cinnamon.nvim',
        event = 'VeryLazy',
        enabled = true,
        config = function()
            require('cinnamon').setup({
                default_keymaps = true,   -- Create default keymaps.
                extra_keymaps = false,    -- Create extra keymaps.
                extended_keymaps = false, -- Create extended keymaps.
                override_keymaps = true,
                default_delay = 10,       -- The default delay (in ms) between each line when scrolling.

            })
        end
    },
    {
        'yamatsum/nvim-cursorline',
        event = 'VeryLazy',
        config = function()
            require('nvim-cursorline').setup {
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = false, -- NOTE: this is handled by `vim-illuminate`
                    min_length = 3,
                    hl = { underline = true },
                }
            }
        end
    },
    {
        'ldelossa/litee.nvim',
        event = {
            "BufEnter *.lua",
            "BufEnter *.go",
            "BufEnter *.rs",
            "BufEnter *.nix",
            "BufEnter *.c",
            "BufEnter *.ml",
            "BufEnter *.html",
            "BufEnter *.js",
            "BufEnter *.jsx",
            "BufEnter *.ts",
            "BufEnter *.tsx",
        },
        dependencies = {
            'ldelossa/litee-symboltree.nvim',
            'ldelossa/litee-calltree.nvim'
        },
        config = function()
            require('litee.lib').setup({
                tree = {
                    -- icon_set = "codicons"
                    icon_set = "nerd"
                },
                panel = {
                    orientation = "right",
                    panel_size  = 50
                }
            })
            require('litee.symboltree').setup({})
            require('litee.calltree').setup({})

            vim.keymap.set('n', '<leader>DS', vim.lsp.buf.document_symbol, { desc = '[D]ocument [S]ymbol Outline' })
            vim.keymap.set('n', '<leader>Co', vim.lsp.buf.outgoing_calls, { desc = '[C]alls [o]utgoing' })
        end
    },
    {
        "vuki656/package-info.nvim",
        ft = 'json',
        dependencies = "MunifTanjim/nui.nvim",
        config = function()
            require('package-info').setup({
                colors = {
                    up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
                    outdated = "#d19a66",   -- Text color for outdated dependency virtual text
                },
            })
            -- Toggle dependency versions
            vim.keymap.set({ "n" }, "<leader>nt", require("package-info").toggle,
                { silent = true, noremap = true, desc = 'Toggle dependency versions' })
            -- Update dependency on the line
            vim.keymap.set({ "n" }, "<leader>nu", require("package-info").update,
                { silent = true, noremap = true, desc = 'Update dependency on the line' })
            -- Delete dependency on the line
            vim.keymap.set({ "n" }, "<leader>nd", require("package-info").delete,
                { silent = true, noremap = true, desc = 'Delete dependency on the line' })
            -- Install a new dependency
            vim.keymap.set({ "n" }, "<leader>ni", require("package-info").install,
                { silent = true, noremap = true, desc = 'Install a new dependency' })
            -- Install a different dependency version
            vim.keymap.set({ "n" }, "<leader>np", require("package-info").change_version,
                { silent = true, noremap = true, desc = 'Install a different dependency version' })
        end
    },
    {
        'stevearc/overseer.nvim',
        cmd = 'OverseerRun',
        opts = {},
    }
})

-- vim.cmd('colorscheme rose-pine')
-- vim.cmd('colorscheme rose-pine')
