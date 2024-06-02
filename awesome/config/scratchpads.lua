local require = require
local group_module = require("module.scratchpad.lua.group")
local scratchpad_module = require("module.scratchpad")
local scratchpad_object = scratchpad_module.object

local my_pads = group_module:new({
    id = "1",
})

my_pads:add_scratchpad(scratchpad_object:new({
    id = "1",
    command = "alacritty",
    group = my_pads,
    client_options = {
        floating = true,
    },
    scratchpad_options = {
        reapply_options = true,
        only_one        = true,
    },
}))

my_pads:add_scratchpad(scratchpad_object:new({
    command = "qalculate-qt",
    id = "2",
    group = my_pads,
    client_options = {
        floating = true,
    },
    scratchpad_options = {
        reapply_options = true,
        only_one        = true,
    },
}))

my_pads:add_scratchpad(scratchpad_object:new({
    command = "qalculate-qt",
    id = "2",
    group = my_pads,
    client_options = {
        floating = true,
    },
    scratchpad_options = {
        reapply_options = true,
        only_one        = true,
    },
}))

my_pads:add_scratchpad(scratchpad_object:new({
    command = "firefox",
    id = "3",
    group = my_pads,
    client_options = {
        floating = true,
    },
    scratchpad_options = {
        reapply_options = true,
        only_one        = true,
    },
}))

my_pads:add_scratchpad(scratchpad_object:new({
    command = "neovide",
    id = "4",
    group = my_pads,
    client_options = {
        floating = true,
    },
    scratchpad_options = {
        reapply_options = true,
        only_one        = true,
    },
}))

-- my_pads.F1_pad = scratchpad_object:new({
--     id = "1",
--     command = "alacritty",
--     group = my_pads,
--     client_options = {
--         floating = true,
--     },
--     scratchpad_options = {
--         reapply_options = true,
--         only_one        = true,
--     },
-- })
-- my_pads.F2_pad = scratchpad_object:new({
--     command = "qalculate-qt",
--     id = "2",
--     group = my_pads,
--     client_options = {
--         floating = true,
--     },
--     scratchpad_options = {
--         reapply_options = true,
--         only_one        = true,
--     },
-- })
return my_pads
