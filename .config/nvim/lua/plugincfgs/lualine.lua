-- local function os_icon()
--     local sysname = vim.uv and vim.uv.os_uname().sysname or vim.loop.os_uname().sysname
--     if sysname == "Linux" then
--         return ""
--     elseif sysname == "Darwin" then
--         return "" -- macOS
--     elseif sysname == "Windows_NT" then
--         return "" -- Windows
--     end
-- end
local function macro_recording()
    local reg = vim.fn.reg_recording()
    if reg ~= "" then
        return "󰑋 REC @" .. reg
    end
    return ""
end
return {
    options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        icons_enabled = true,
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(str)
                    return str:sub(1, 3)
                end,
                gui = "bold",
            },
        },
        lualine_b = {
            { "branch", icon = "", color = { gui = "bold" } },
        },
        -- 3. ACTIVE FILE & MACROS (PITCH BLACK BACKGROUND)
        lualine_c = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = {
                    error = "󰅚 ",
                    warn = "󰀪 ",
                    hint = "󰌶 ",
                    info = "󰋽 ",
                },
                colored = true,
            },
            {
                "filename",
                file_status = true,
                path = 1,
                symbols = {
                    modified = "●",
                    readonly = "",
                    unnamed = "[No Name]",
                    newfile = "",
                },
            },
            {
                macro_recording,
            },
        },
        lualine_x = {
            {
                "diff",
                symbols = { added = "+", modified = "~", removed = "-" },
                colored = true,
                source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                end,
            },
            { "filetype", icon_only = false },
            -- { os_icon },
            -- {
            --     "encoding",
            --     show_bomb = false,
            -- },
        },
        lualine_y = {
            { "progress", gui = "bold" },
        },
        -- 6. BLUE LOCATION BLOCK
        lualine_z = {
            { "location", gui = "bold" },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
}
