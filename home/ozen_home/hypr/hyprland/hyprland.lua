-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("GDK_SCALE", "1.333333")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GTK_IM_MODULE", "simple")


------------------
---- MONITORS ----
------------------

hl.monitor({
	output   = "",
	mode     = "preferred",
	position = "auto",
	scale    = "1.3333333",
})
hl.monitor({
	output   = "HDMI-a-1",
	mode     = "2560x1440@143",
	position = "auto",
	scale    = "1.3333333",
})
hl.monitor({
	output   = "DP-1",
	mode     = "3840x2160@59",
	position = "auto",
	scale    = "1.3333333",
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "ghostty"
local fileManager = "thunar"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
  hl.exec_cmd("noctalia")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland.service")
  hl.exec_cmd("xwaylandvideobridge &")
  hl.exec_cmd("easyeffects --service-mode -w")
end)

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 2,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        blur = {
            enabled   = true,
            size      = 10,
            passes    = 4,
			new_optimizations = true,
            vibrancy  = 0.5,
        },
    },
})

hl.curve("myBezier",          { type = "bezier", points = { {0.05, 0.9},    {0.1, 1.05}     } })

hl.animation({ leaf = "windows",       enabled = true,  speed = 7, bezier= "myBezier" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 7, bezier = "default",       style = "popin 80%" })
hl.animation({ leaf = "border",        enabled = true,  speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle",   enabled = true,  speed = 8, bezier = "default" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 6, bezier = "default"})

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	gestures = {
		workspace_swipe_touch = true,
		workspace_swipe_distance = 200,
		workspace_swipe_min_speed_to_force = 0,
	},
})
---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout  = "us",
		kb_variant = "alt-intl",
		kb_model   = "",
		kb_options = "",
		kb_rules   = "",

		follow_mouse = 1,

		sensitivity = 0.2,

		touchpad = {
			disable_while_typing = true,
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace"
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ "maximized", "toggle" }))
hl.bind(mainMod .. " + I", hl.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + I", hl.exec_cmd("hyprshot -m region"))

-- noctalia
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("noctalia msg session lock"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle controlCenter"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd("noctalia msg settings-toggle"))

hl.bind(mainMod .. " + A",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + D", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + W",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Z",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + A",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + W",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + Z",  hl.dsp.window.move({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10 
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -d asus::kbd_backlight set 1+"),                  { locked = true, repeating = true })
hl.bind("XF86KbdBrightnessDown",  hl.dsp.exec_cmd("brightnessctl -d asus::kbd_backlight set 1-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

