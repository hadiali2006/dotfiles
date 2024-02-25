local filesystem = require("gears.filesystem")


-- List of apps to start once on start-up
return {
    run_on_start_up = {
        "picom --config " .. filesystem.get_configuration_dir() .. "assets/picom.conf",
        "feh --bg-fill --random ~/wallpapers/",
        "unclutter",
        "sxhkd",


        --[[ 
    Add applications that need to be killed between reloads
    to avoid multipled instances, inside the awspawn script ]]--

        -- Spawn "dirty" apps that can linger between sessions
        --filesystem.get_configuration_dir() .. "scripts/autostartonce.sh"
        --"~/.config/awesome/scripts/autostartonce.sh"


    }
}
