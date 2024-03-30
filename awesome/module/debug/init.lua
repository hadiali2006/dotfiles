local naughty = require("naughty")

-- Function to create and show a notification
local function notif(title, message)
    naughty.notify({
        title = title,
        text = message,
        timeout = 5,  -- Timeout in seconds
        position = "top_right"  -- Position of the notification
    })
end

local gears_debug = require('gears.debug')
local out = function (message)

  local file = io.open("err.log", "w")
    file:write(os.date("%Y-%m-%d %T W: awesome: ") .. tostring(message) .. "\n")
end

-- variadic log function. Pass as many things to it as you want,
-- of any type, and it will print them out
-- separated by spaces
local function log(...)
  local message = ''
  for i = 1, select('#', ...) do
    local arg = select(i, ...)
    local the_type = type(arg)
    -- gears_debug.print_warning("type: " .. the_type)
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
  notif(message)
  out(message)
end

return log
