-- Minimal first-boot Hyprland configuration. Add appearance and workflow
-- policy only after the basic VM session has been validated.

local terminal = "kitty"
local launcher = "fuzzel"
local file_manager = "nautilus"
local main_mod = "SUPER"

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "rgba(cba6f7ff)",
            inactive_border = "rgba(45475acc)",
        },
        layout = "dwindle",
    },
    decoration = {
        rounding = 8,
        shadow = { enabled = true },
        blur = { enabled = true, size = 3, passes = 1 },
    },
    animations = { enabled = true },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        touchpad = { natural_scroll = false },
    },
    dwindle = { preserve_split = true },
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
})

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start waybar.service")
    hl.exec_cmd("mako")
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
end)

hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind(main_mod .. " + F", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + W", hl.dsp.window.close())
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + L", hl.dsp.exec_cmd("pidof hyprlock || hyprlock"))
hl.bind(main_mod .. " + M", hl.dsp.exit())

hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
