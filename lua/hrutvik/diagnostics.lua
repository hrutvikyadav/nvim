-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = opts.name,
    })
end

sign({ name = 'DiagnosticSignError', text = "" })
sign({ name = 'DiagnosticSignWarn', text = "" })
sign({ name = 'DiagnosticSignHint', text = "" })
sign({ name = 'DiagnosticSignInfo', text = "" })
-- work for firacode
--  error = "", "", "", "", "",

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

-- Show diagnostic popup on cursor hover
--local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
--vim.api.nvim_create_autocmd("CursorHold", {
--callback = function()
--vim.diagnostic.open_float(nil, { focusable = false })
--end,
--group = diag_float_grp,
--})
-- same thing with vimL?
--vim.cmd([[
--set signcolumn=yes
--autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
--]])
--
