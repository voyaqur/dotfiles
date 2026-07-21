local config = {}
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local launch_prefix = "uwsm app -- "
local viMotion = true
local augs = {
    term = " +new-window"
}
function config.setup(programs)
    hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(launch_prefix .. programs.terminal .. augs.term))
    local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
    closeWindowBind:set_enabled(true)
    hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
    -- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
    hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("uwsm stop"))
    hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("pidof hyprlock || uwsm app -- hyprlock"))
    hl.bind(mainMod .. " + W", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy -t image/png'))
    hl.bind(mainMod .. " + E",
        hl.dsp.exec_cmd(launch_prefix .. programs.terminal .. augs.term .. " -e " .. programs.fileManager))
    hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(programs.menu))
    hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(launch_prefix .. programs.browser))
    hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
    hl.bind(mainMod .. " + A", hl.dsp.layout("togglesplit"))
    hl.bind(mainMod .. " + Y", function()
        local cur = hl.get_active_workspace() and hl.get_active_workspace().tiled_layout
        if not cur then
            return
        end
        if cur == "dwindle" then
            hl.dispatch(hl.dsp.layout("swapsplit"))
        elseif cur == "master" then
            hl.dispatch(hl.dsp.layout("swapwithmaster"))
        end
    end)
    --Scrolling motion
    local scrollingBinds = {
        [" + period"]         = "move +col",
        [" + comma"]          = "move -col",
        [" + SHIFT + period"] = "swapcol r",
        [" + SHIFT + comma"]  = "swapcol l",
        [" + CTRL + period"]  = "consume_or_expel prev",
        [" + CTRL + comma"]   = "consume_or_expel next",
        [" + ALT + period"]   = "colresize +conf",
        [" + ALT + comma"]    = "colresize -conf",
    }
    local masterBinds = {
        [" + O"]         = "removemaster",
        [" + I"]         = "addmaster",
        [" + SHIFT + M"] = "orientationcycle",
        [" + CTRL + H"]  = "mresize -0.05",
        [" + CTRL + L"]  = "mresize +0.05",
    }
    for key_combo, layout_cmd in pairs(scrollingBinds) do
        hl.bind(mainMod .. key_combo, function()
            local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
            if not workspace then return end
            if workspace.tiled_layout == "scrolling" then
                hl.dispatch(hl.dsp.layout(layout_cmd))
            end
        end)
    end
    for key_combo, layout_cmd in pairs(masterBinds) do
        hl.bind(mainMod .. key_combo, function()
            local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
            if not workspace then return end

            -- Only execute the layout action if we are actively using the master layout
            if workspace.tiled_layout == "master" then
                hl.dispatch(hl.dsp.layout(layout_cmd))
            end
        end)
    end
    hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
    hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

    hl.bind(mainMod .. " + G", hl.dsp.group.toggle(), { desc = "Toggle window group" })
    hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.next(), { desc = "Next window in group" })
    hl.bind(mainMod .. " + tab", function()
        local layouts   = { "scrolling", "dwindle", "master", "monocle" }
        local workspace = hl.get_active_workspace()
        if hl.get_active_special_workspace() then
            workspace = hl.get_active_special_workspace()
        end
        local next_layout = "dwindle"
        if not workspace then
            return
        end
        for i = 1, #layouts do
            if layouts[i] == workspace.tiled_layout then
                local next_layout_idx = (i % #layouts) + 1
                next_layout = layouts[next_layout_idx]
                break
            end
        end

        hl.dispatch(hl.dsp.exec_cmd('notify-send -t 1000 "Layout changed" "changed to ' .. next_layout .. '"'))
        if workspace.special then
            hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
        else
            hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
        end
    end)
    hl.define_submap("resize", function()
        local step = 40
        if (viMotion) then
            hl.bind("H", hl.dsp.window.resize({ x = -step, y = 0, relative = true }), { repeating = true })
            hl.bind("L", hl.dsp.window.resize({ x = step, y = 0, relative = true }), { repeating = true })
            hl.bind("K", hl.dsp.window.resize({ x = 0, y = -step, relative = true }), { repeating = true })
            hl.bind("J", hl.dsp.window.resize({ x = 0, y = step, relative = true }), { repeating = true })
        end
        hl.bind("left", hl.dsp.window.resize({ x = -step, y = 0, relative = true }), { repeating = true })
        hl.bind("right", hl.dsp.window.resize({ x = step, y = 0, relative = true }), { repeating = true })
        hl.bind("up", hl.dsp.window.resize({ x = 0, y = -step, relative = true }), { repeating = true })
        hl.bind("down", hl.dsp.window.resize({ x = 0, y = step, relative = true }), { repeating = true })
        hl.bind("ESCAPE", hl.dsp.submap("reset"))
        hl.bind("RETURN", hl.dsp.submap("reset"))
    end)
    for vi, kb in pairs({ H = "left", L = "right", K = "up", J = "down" }) do
        hl.bind(mainMod .. " + " .. kb, hl.dsp.focus({ direction = kb }));
        hl.bind(mainMod .. " + SHIFT + " .. kb, hl.dsp.window.move({ direction = string.sub(kb, 0, 1) }));
        -- vi mode
        if (viMotion) then
            hl.bind(mainMod .. " + " .. vi, hl.dsp.focus({ direction = kb }));
            hl.bind(mainMod .. " + SHIFT + " .. vi, hl.dsp.window.move({ direction = string.sub(kb, 0, 1) }));
        end
    end
    -- vim key bind
    for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end

    -- Example special workspace (scratchpad)
    hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
    hl.bind(mainMod .. " + CTRL + K", hl.dsp.workspace.toggle_special("keepassxc"))
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
    hl.bind(mainMod .. " + semicolon", hl.dsp.window.cycle_next(), { desc = "Cycle to next window" })
    -- Scroll through existing workspaces with mainMod + scroll
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

    -- Move/resize windows with mainMod + LMB/RMB and dragging
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Laptop multimedia keys for volume and LCD brightness
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
        { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
        { locked = true, repeating = true })
    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
        { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
        { locked = true, repeating = true })

    -- Requires playerctl
    hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
end

return config
