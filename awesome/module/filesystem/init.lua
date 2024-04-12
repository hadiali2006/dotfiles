local GFile = require("lgi").Gio.File

---@class filesystem
local filesystem = {}

--- Read a file with the specified format (or "a") and close the file
---@param path string
---@param format openmode
---@return any
function filesystem.read(path, format)
    local f = assert(io.open(path, "r"))
    local c = f:read(format or "a")
    f:close()
    return c
end

--- List files in a directory
---@param path string
---@param absolute boolean?
---@return table
function filesystem.ls_files(path, absolute)
    local files = GFile.new_for_path(path):enumerate_children("standard::*", 0)
    local files_filtered = {}

    if not files then
        return {}
    end

    for file in
        function()
            return files:next_file()
        end
    do
        if file:get_file_type() == "REGULAR" then
            local file_name = file:get_display_name()
            file_name = absolute and (path:gsub("[/]*$", "") .. "/" .. file_name) or file_name
            table.insert(files_filtered, file_name)
        end
    end

    return files_filtered
end

return filesystem
