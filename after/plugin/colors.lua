function CT(color)
    color = color or 'base16-rose-pine-moon'
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "none" })

    -- Automatically source the custom highlight file when Neovim starts
    --vim.cmd("autocmd VimEnter * source ~/.config/nvim/after/colors/mycolors.lua")
    dofile(vim.fn.stdpath("config") .. "/after/colors/mycolors.lua")
end

vim.cmd('hi IndentGuideLight guifg=#575279 guibg=#cecacd')  -- Light theme h1
vim.cmd('hi IndentGuideLight2 guifg=#000000 guibg=#666666') -- Light theme h2
vim.cmd('hi IndentGuideDark guifg=#9ccfd8 guibg=#21202e')   -- Dark theme h1
vim.cmd('hi IndentGuideDark2 guifg=#eb6f92')                -- Dark2 theme transparent
vim.cmd('hi IndentGuideBlack guifg=#000000')                -- Dark2 theme transparent
-- shades of red
vim.api.nvim_set_hl(0, "IndentGuideRed1", { bg = "#E45649", fg = "" })
vim.api.nvim_set_hl(0, "IndentGuideRed2", { bg = "#DC322F", fg = "" })
vim.api.nvim_set_hl(0, "IndentGuideRed3", { bg = "#CB4B16", fg = "" })
vim.api.nvim_set_hl(0, "IndentGuideRed4", { bg = "#FF0000", fg = "" })
vim.api.nvim_set_hl(0, "IndentGuideRed5", { bg = "#800000", fg = "#21202e" })
vim.api.nvim_set_hl(0, "IndentGuideRed6", { bg = "#EF2929", fg = "#666666" })
vim.api.nvim_set_hl(0, "IndentGuideRed7", { bg = "#F7768E", fg = "#cecacd" })

CT("rose-pine")
