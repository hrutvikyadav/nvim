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

CT("rose-pine")
