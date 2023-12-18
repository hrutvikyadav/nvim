local overseer = require("overseer")

overseer.load_template("commontasks.second_task")
overseer.load_template("format.react_files_task")
overseer.load_template("markdown.preview_task")

-- Markdown Preview
vim.api.nvim_create_user_command("MdPreview", function()
    -- vim.cmd('OverseerExtraTasks')

    -- local overseer = require("overseer")
    overseer.run_template({ name = "markdown preview" }, function(task)
        if task then
            task:add_component({ "restart_on_save", paths = { vim.fn.expand("%:p") } })
            local main_win = vim.api.nvim_get_current_win()
            overseer.run_action(task, "open vsplit")
            vim.api.nvim_set_current_win(main_win)
        else
            vim.notify("MdPreview not supported for filetype " .. vim.bo.filetype, vim.log.levels.ERROR)
        end
    end)
end, {})

-- format react with watch
vim.api.nvim_create_user_command("FmtReact", function()
    overseer.run_template({ name = "format react.js" }, function(task)
        if task then
            task:add_component({ "restart_on_save", paths = { vim.cmd('echo getcwd() .. "/src"') } })
        else
            vim.notify("React format not supported", vim.log.levels.ERROR)
        end
    end)
end, {})

vim.keymap.set("n", "<leader><F3>", "<cmd>FmtReact<cr>")
