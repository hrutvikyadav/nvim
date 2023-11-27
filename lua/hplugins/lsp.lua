local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })

    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true, desc = 'LSP: [g]oto [r]eferences' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = 'LSP: [g]oto [d]efinition' })
    vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = true, desc = 'LSP: [g]oto [I]mplementation' })
    --vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {buffer = true, desc = 'LSP: type [D]efinition'})
    vim.keymap.set('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
        { buffer = true, desc = 'LSP: [T]ype Definition' })
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
        { buffer = true, desc = 'LSP: [g]oto [D]eclaration' })

    vim.keymap.set('n', '<leader>Ds', '<cmd>Telescope lsp_document_symbols<cr>',
        { buffer = true, desc = 'LSP: [D]ocument [s]ymbols' })
    vim.keymap.set('n', '<leader>Ws', '<cmd>Telescope lsp_workspace_symbols<cr>',
        { buffer = true, desc = 'LSP: [W]orkspace [s]ymbols' })
end)

lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    'tsserver',
    'eslint',
    'rust_analyzer',
    'lua_ls',
})

-- allow only single server to format per file type - mapped to `gq`
--lsp.format_mapping('gq', {
lsp.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000,
    },
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        -- if you have a working setup with null-ls you can specify filetypes it can format.
        -- ['null-ls'] = {'javascript', 'typescript'},
    }
})

-- setup lua_ls specifically for nvim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
-- rust with rust-tools
lsp.skip_server_setup({ 'rust_analyzer' })
-- setup all other installed LSP's
lsp.setup()

--#region
-- RUST
--
local rust_tools = require('rust-tools')

rust_tools.setup({
    tools = {
        runnables = {
            use_telescope = true,
        },
    },
    server = {
        on_attach = function(_, bufnr)
            print('hello from rust_tools')
            vim.keymap.set('n', 'K', rust_tools.hover_actions.hover_actions,
                { buffer = bufnr, desc = 'RUST TOOLS: hover action' })
            -- Code action groups
            vim.keymap.set("n", "<leader>ca", rust_tools.code_action_group.code_action_group,
                { buffer = bufnr, desc = 'RUST TOOLS: code action groups' })
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>',
                { buffer = true, desc = 'LSP: [g]oto [r]eferences' })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true, desc = 'LSP: [g]oto [d]efinition' })
            vim.keymap.set('n', 'gI', vim.lsp.buf.implementation,
                { buffer = true, desc = 'LSP: [g]oto [I]mplementation' })
            --vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, {buffer = true, desc = 'LSP: type [D]efinition'})
            vim.keymap.set('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<cr>',
                { buffer = true, desc = 'LSP: [T]ype Definition' })
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>',
                { buffer = true, desc = 'LSP: [g]oto [D]eclaration' })

            vim.keymap.set('n', '<leader>Ds', '<cmd>Telescope lsp_document_symbols<cr>',
                { buffer = true, desc = 'LSP: [D]ocument [s]ymbols' })
            vim.keymap.set('n', '<leader>Ws', '<cmd>Telescope lsp_workspace_symbols<cr>',
                { buffer = true, desc = 'LSP: [W]orkspace [s]ymbols' })
        end,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    }
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_select_opts = { behaviour = cmp.SelectBehavior.Select }

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'luasnip' }
    },
    mapping = {
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        --['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
        --['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        -- changing the order of fields so the icon is the first
        fields = { 'menu', 'abbr', 'kind' },

        -- here is where the change happens
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
                nvim_lua = 'Π',
                git = '',
            }
            item.menu = menu_icon[entry.source.name]
            return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end,
        expandable_indicator = true,
    }
})
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
}
)
