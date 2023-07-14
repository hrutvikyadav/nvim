function CT(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme('base16-rose-pine-moon')

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

CT()
