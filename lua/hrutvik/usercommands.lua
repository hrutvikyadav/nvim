vim.api.nvim_create_user_command('EditorSupport', function()
    -- hi Whitespace guifg=#CC0000 highlight spaces from listchars -- NOTE: linked to NonText by default;; with IBL off, this can be changed to modify colors of listchars
    -- hi OnlySpaces guibg=#CC0000-- hl for lines with only spaces and trailing spaces
    vim.api.nvim_set_hl(0, 'OnlySpaces', { bg = '#CC0000' })
    -- match OnlySpaces /\s\+$/
    vim.cmd([[
        match OnlySpaces /\s\+$/
        set list!
        IBLToggle
        IBLToggle
    ]])
    -- IBLToggle
end, {})

vim.api.nvim_create_user_command('OverseerExtraTasks', function()
    require("hplugins.overseer")
    vim.cmd('OverseerRun')
end, {})
