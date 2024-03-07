-- Return a table containing all bar modules, with a name attached
-- to each.
return {
    launcher  = require(... .. ".launcher"),
    taglist   = require(... .. ".taglist"),
    tasklist  = require(... .. ".tasklist"),
    systray   = require(... .. ".systray"),
    layoutbox = require(... .. ".layoutbox"),
    vol       = require(... .. ".vol"),
    cal       = require(... .. ".cal"),
}
