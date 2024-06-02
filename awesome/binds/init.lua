local require = require
return {
    global = require(... .. ".global"),
    client = require(... .. ".client"),
}
