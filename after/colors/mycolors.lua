--Set additional highlights to SignColumn and LineNr to make transparency better looking
local function set_highlight(group, attributes)
    local command = "hi " .. group
    for attr, value in pairs(attributes) do
        command = command .. " " .. attr .. "=" .. value
    end
    -- for debug
    print(command)
    vim.api.nvim_command(command)
end

local violet = "#817c9c"
local cyan = "#9ccfd8"
local red = "#ea9a97"
local white = "#ecebf0"

function AddCT(is_def)
    -- use default GitGutter colors or a modified combination
    --local is_def_huh = is_def or true;

    -- clear both
    vim.api.nvim_set_hl(0, "NormalNC", {})
    vim.api.nvim_set_hl(0, "SignColumn", {})

    if is_def then
        set_highlight("LineNr", { guifg = violet, guibg = "NONE", ctermfg = 11 })
        set_highlight("GitGutterAdd", { guifg = red, guibg = "NONE" })
        set_highlight("GitGutterChange", { guifg = cyan, guibg = "NONE" })
        set_highlight("GitGutterDelete", { guifg = white, guibg = "NONE" })
    else
        set_highlight("LineNr", { guifg = violet, guibg = "NONE", ctermfg = 11 })
        set_highlight("GitGutterAdd", { guifg = cyan, guibg = "NONE" })
        set_highlight("GitGutterChange", { guifg = violet, guibg = "NONE" })
        set_highlight("GitGutterDelete", { guifg = red, guibg = "NONE" })
    end
end

AddCT(true)
