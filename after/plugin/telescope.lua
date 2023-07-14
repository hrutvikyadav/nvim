local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'TELESCOPE [s]earch pwd [f]iles' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'TELESCOPE git files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'TELESCOPE live grep pwd files' })

vim.keymap.set('n', '<leader>Gc', builtin.git_commits, { desc = 'TELESCOPE [G]it [c]ommits' })
vim.keymap.set('n', '<leader>Gb', builtin.git_branches, { desc = 'TELESCOPE [G]it [b]ranches' })
