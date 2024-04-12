local naughty = require("naughty")
local gears_debug = require('gears.debug')

local out = function (message)
  local file = io.open("err.log", "w")
    file:write(os.date("%Y-%m-%d %T W: awesome: ") .. tostring(message) .. "\n")
end

local function log(do_notif, ...)
  local message = ''
  for i = 1, select('#', ...) do
    local arg = select(i, ...)
    local the_type = type(arg)
    if the_type == 'nil' then
      message = message .. 'nil'
    elseif the_type == 'boolean' then
      message = message .. tostring(arg)
    elseif the_type == 'string' or the_type == 'number' then
      message = message .. arg
    elseif the_type == 'table' then
      message = message .. gears_debug.dump_return(arg)
    end
    message = message .. ' '
  end
  if do_notif then
    naughty.notify({
        text = message,
        timeout = 5,
        position = "top_right"
    })
  end
  out(message)
end

return log
