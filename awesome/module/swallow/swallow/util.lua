---@meta
---@module "swallow.util"

local pairs = pairs
local require = require
local string = string
local tostring = tostring

local awful = require("awful")

local util = {}

-- check if element exist in table
-- returns true if it is
---@param element any
---@param source table
util.is_in_table = function(element, source)
    local res = false
    for _, value in pairs(source) do
        if element:match(value) then
            res = true
            break
        end
    end
    return res
end


---@param client client
---@param current_tag tag
util.turn_on = function(client, current_tag)
    if not current_tag and client.screen.selected_tag then
        current_tag = client.screen.selected_tag
    end
    local client_tags = {}
    for _, tag in pairs(client:tags()) do
        if tag ~= current_tag then
            table.insert(client_tags, tag)
        end
    end
    client:tags(client_tags)
    client.sticky = false
end

---@param client client
util.turn_off = function(client)
    local current_tag
    if client.screen.selected_tag then
        current_tag = client.screen.selected_tag
    end
    local client_tags = { current_tag }
    for _, tag in pairs(client:tags()) do
        if tag ~= current_tag then
            table.insert(client_tags, tag)
        end
    end
    client:tags(client_tags)
    client:activate({})
end

---@param target_client client
---@param source_client client
util.sync = function(target_client, source_client)
    if not source_client or not target_client then
        return
    end
    if not source_client.valid or not target_client.valid then
        return
    end
    if source_client.modal then
        return
    end
    target_client.floating = source_client.floating
    target_client.maximized = source_client.maximized
    target_client.above = source_client.above
    target_client.below = source_client.below
    target_client:geometry(source_client:geometry())
    -- TODO: Should also copy over the position in a tiling layout
end

return util
