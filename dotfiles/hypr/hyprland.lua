-- Minimal first-boot Hyprland configuration. Add appearance and workflow
-- policy only after the basic VM session has been validated.

local terminal = "kitty"
local launcher = "rofi -show drun"
local file_manager = "nautilus"
local browser = "xdg-open https://"
local bluetooth_manager = "blueman-manager"
local spotify = "spotify-launcher"
local main_mod = "SUPER"
local theme = dofile(os.getenv("HOME") .. "/.config/hypr/theme.lua")
local user_bin = os.getenv("HOME") .. "/.local/bin/"
local theme_chooser = user_bin .. "linux-setup-theme-menu"
local power_menu = user_bin .. "linux-setup-power-menu"
local theme_restore = user_bin .. "linux-setup-theme-restore"
local screenshot = user_bin .. "linux-setup-screenshot"
local kensington_kb435_volume = user_bin .. "linux-setup-kensington-kb435-volume"

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
            active_border = theme.active_border,
            inactive_border = theme.inactive_border,
        },
        layout = "dwindle",
    },
    decoration = {
        rounding = 8,
        shadow = { enabled = true },
        blur = { enabled = true, size = 6, passes = 2 },
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

-- Keep window transitions smooth, but slightly snappier than Hyprland's defaults.
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })
hl.curve("easeOutCubic", { type = "bezier", points = { {0.33, 1}, {0.68, 1} } })
hl.animation({ leaf = "windows", enabled = true, speed = 6, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.75, bezier = "easeOutCubic", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.75, bezier = "easeOutCubic", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.75, bezier = "easeOutCubic", style = "slide" })

hl.on("hyprland.start", function()
    hl.exec_cmd(theme_restore)
    hl.exec_cmd("systemctl --user start waybar.service")
    hl.exec_cmd("mako")
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
end)

hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind(main_mod .. " + CTRL + SPACE", hl.dsp.exec_cmd(theme_chooser))
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(main_mod .. " + SHIFT + F", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(main_mod .. " + SHIFT + B", hl.dsp.exec_cmd(bluetooth_manager))
hl.bind(main_mod .. " + S", hl.dsp.exec_cmd(spotify))
hl.bind(main_mod .. " + W", hl.dsp.window.close())
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + L", hl.dsp.exec_cmd("pidof hyprlock || hyprlock"))
hl.bind(main_mod .. " + M", hl.dsp.exit())
hl.bind(main_mod .. " + ESCAPE", hl.dsp.exec_cmd(power_menu))
hl.bind("PRINT", hl.dsp.exec_cmd(screenshot))
-- The Kensington KB435 screenshot key emits the Windows shortcut Super+Shift+S.
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot))
hl.bind("XF86AudioLowerVolume",
    hl.dsp.exec_cmd(kensington_kb435_volume .. " down"))
hl.bind("XF86AudioRaiseVolume",
    hl.dsp.exec_cmd(kensington_kb435_volume .. " up"))
hl.bind("XF86AudioMute",
    hl.dsp.exec_cmd(kensington_kb435_volume .. " mute"))
hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(main_mod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(main_mod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(main_mod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(main_mod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
