local scratchpad = require("module.scratchpad")
local pads = {}
pads.F1_pad = scratchpad:new({
    command = "alacritty",
    options = {
        ontop    = true,
        above    = true,
        floating = true,
    }
})
pads.F2_pad = scratchpad:new({
    command = "qalculate-qt",
    options = {
        ontop    = true,
        above    = true,
        floating = true,
    }
})
pads.F3_pad = scratchpad:new({
    command = "alacritty -e ncmpcpp",
    options = {
        ontop    = true,
        above    = true,
        floating = true,
    }
})
pads.F4_pad = scratchpad:new({
    command = "alacritty -e lf",
    options = {
        ontop    = true,
        above    = true,
        floating = true,
    }
})
return pads
