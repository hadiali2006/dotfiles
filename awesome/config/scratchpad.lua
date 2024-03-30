local scratchpad = require("module.scratchpad")
local sp_config = {
    enabled = true,
    close_on_focus_lost = true,
    reapply_props = true,
}
if true then
    scratchpad:init {
        close_on_focus_lost = sp_config.close_on_focus_lost,
        reapply_props       = sp_config.reapply_props,
    }

    local commands = { "ncmpcpp", "" }
    for i=1,2 do
        local command
        if #commands[i] > 0 then
            command = "alacritty" .. " --class scratch_term_" .. i .. " -e " .. commands[i]
        else
            command = "alacritty" .. " --class scratch_term_" .. i
        end
        scratchpad:add {
            class               = "scratch_term_" .. i,
            command             = command,
            client_props = {
                floating  = true,
                sticky    = false,
                geometry  = {
                    width   = 1720,
                    height  = 680,
                    x       = 100,
                    y       = 28,
                },
            },
            hotkey        = {
                modifiers   = { "Mod4" },
                key         = "F" .. i,
                description = "Empty Terminal " .. i,
                group       = "Scratchpad",
            },
        }
    end

    for i=3,4 do
        scratchpad:add_temp {
            client_props = {
                floating  = true,
                sticky    = false,
                geometry  = {
                    width   = 1720,
                    height  = 680,
                    x       = 100,
                    y       = 28,
                },
            },
            hotkey        = {
                modifiers               = { "Mod4" },
                client_toggle_modifiers = { "Mod4", "Shift" },
                key                     = "F" .. i,
                description             = "Temporary Scratchpad " .. i - 2,
                group                   = "Scratchpad",
            },
        }
    end
end
