vim.api.nvim_create_user_command('EditorSupport', function()
    -- hi Whitespace guifg=#CC0000 highlight spaces from listchars -- NOTE: linked to NonText by default
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
