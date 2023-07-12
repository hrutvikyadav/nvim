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
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	{
	'nvim-telescope/telescope.nvim', tag = '0.1.2',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
			  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "rust", "javascript", "html" },
			  sync_install = false,
			  highlight = { enable = true },
			  indent = { enable = true },  
			})
		end
	},
	"nvim-treesitter/playground",
	"theprimeagen/harpoon",
	"mbbill/undotree",
	"tpope/vim-fugitive",
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			'williamboman/mason.nvim',
			build = function()
			pcall(vim.cmd, 'MasonUpdate')
			end,
			},
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
		}
	}
})

-- vim.cmd('colorscheme rose-pine')
