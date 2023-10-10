local zen = require("zen-mode")

vim.keymap.set('n', '<leader>Z', function()
    zen.toggle({
        --window = {
        --    width = .60,
        --}
    })
end, { desc = "Toggle ZenMode" })
