local require = require
return {
    launcher   = require(... .. ".launcher"),
    taglist    = require(... .. ".taglist"),
    tasklist   = require(... .. ".tasklist"),
    menu       = require(... .. ".menu"),
    layoutbox  = require(... .. ".layoutbox"),
    volume     = require(... .. ".volume"),
    time       = require(... .. ".time"),
    brightness = require(... .. ".ddcutil"),
    date       = require(... .. ".date"),
}
