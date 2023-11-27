--Set additional highlights to SignColumn and LineNr to make transparency better looking
local function set_highlight(group, attributes)
    local command = "hi " .. group
    for attr, value in pairs(attributes) do
        command = command .. " " .. attr .. "=" .. value
    end
    -- NOTE: for debug printing
    -- print(command)
    vim.api.nvim_command(command)
end

local violet = "#817c9c"
local cyan = "#9ccfd8"
local red = "#ea9a97"
local white = "#ecebf0"
local rp_red = "#eb6f92"
local rp_purple = "#C4A7E7"

--:hi DiagnosticError ctermfg=1 guifg=#CC0000
local foreign_red = "#CC0000"

-- rainbow delimiters
set_highlight("RainbowDelimiterRPViolet", { guifg = violet })
set_highlight("RainbowDelimiterRPPurple", { guifg = rp_purple })
set_highlight("RainbowDelimiterRPCyan", { guifg = cyan })
set_highlight("RainbowDelimiterRPRed", { guifg = rp_red })

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

        set_highlight("GitSignsAdd", { guifg = red, guibg = "NONE" })
        set_highlight("GitSignsChange", { guifg = cyan, guibg = "NONE" })
        set_highlight("GitSignsDelete", { guifg = white, guibg = "NONE" })
        -- NOTE: experimental
        --set_highlight("DiagnosticError", { guifg = foreign_red, guibg = "NONE", ctermfg = 1 })
    else
        set_highlight("LineNr", { guifg = violet, guibg = "NONE", ctermfg = 11 })
        set_highlight("GitGutterAdd", { guifg = cyan, guibg = "NONE" })
        set_highlight("GitGutterChange", { guifg = red, guibg = "NONE" })
        set_highlight("GitGutterDelete", { guifg = rp_red, guibg = "NONE" })

        set_highlight("GitSignsAdd", { guifg = cyan, guibg = "NONE" })
        set_highlight("GitSignsChange", { guifg = red, guibg = "NONE" })
        set_highlight("GitSignsDelete", { guifg = rp_red, guibg = "NONE" })
        -- NOTE: experimental
        --set_highlight("DiagnosticError", { guifg = foreign_red, guibg = "NONE", ctermfg = 1 })
    end
end

AddCT()
