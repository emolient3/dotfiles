-- binds.lua
local mainMod = "SUPER"
local menu = "..." -- ajusta esto a lo que tenías como $menu

---------------------------
---- BINDS BÁSICS ----
---------------------------
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
-- hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + Z", hl.dsp.layout("togglesplit")) -- dwindle

---------------------------------------
---- RESIZE (SUPER+ALT+hjkl) ----
---------------------------------------
-- Confirmado en la wiki: window.resize acepta x/y/relative
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-------------------------------------
---- MOVER FOCUS ----
-------------------------------------
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

---------------------------------
---- CAMBIAR WORKSPACE ----
---------------------------------
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + n", hl.dsp.focus({ workspace = 11 }))

-----------------------------------------------
---- MOVER VENTANA A WORKSPACE (SHIFT) ----
-----------------------------------------------
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + n", hl.dsp.window.move({ workspace = 11 }))

-------------------------------
---- SWAP DE VENTANAS ----
-------------------------------
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "down" }))

----------------------------------
---- FULLSCREEN / MAXIMIZE ----
----------------------------------
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
-----------------------------------------
---- MOVER VENTANA EN EL LAYOUT ----
-----------------------------------------
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "down" }))

---------------------------------------
---- SCRATCHPAD / ESPECIALES ----
---------------------------------------
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + i", hl.dsp.window.move({ workspace = "+0" }))
hl.bind(mainMod .. " + x", hl.dsp.workspace.toggle_special("basura"))

-- Scroll por workspaces existentes
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

----------------------------------------
---- MOVER/REDIMENSIONAR CON MOUSE ----
----------------------------------------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-------------------------------------------------
---- TECLAS MULTIMEDIA (volumen/brillo) LAPTOP ----
-------------------------------------------------
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-----------------------------------
---- SELECTOR DE VENTANAS ----
-----------------------------------
hl.bind(mainMod .. " + a", hl.dsp.exec_cmd("/home/cali/.local/bin/kitty-float"))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("/home/cali/.local/bin/set_wallpaper.sh"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("/home/cali/.local/bin/sway-launcher.sh"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("/home/cali/.local/bin/hide_window.sh"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("/home/cali/.local/bin/toogle-monitor-ON-OFF.sh"))

--  centerwindow:
hl.bind(mainMod .. " + CTRL + u", hl.dsp.window.center())

hl.bind(mainMod .. " + c", hl.dsp.exec_cmd("/home/cali/.local/bin/workspaces89"))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.exec_cmd("/home/cali/.local/bin/toggle_fullscreen_mode.sh"))

-- ALT+Tab:
hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

hl.bind(mainMod .. " + SHIFT + x", hl.dsp.exec_cmd("/home/cali/.local/bin/toggle_basura_workspace.sh"))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("/home/cali/.local/bin/config.sh"))
hl.bind(mainMod .. " + b", hl.dsp.exec_cmd("/home/cali/.local/bin/toggle-hyprpanel.sh"))

-- Screenshots
hl.bind(mainMod .. " + home", hl.dsp.exec_cmd("hyprshot -m window -z"))
hl.bind("CTRL + home", hl.dsp.exec_cmd("hyprshot -m region -z"))

-- bind = , PRINT, exec, hyprshot -m output  (comentado en el original)

-----------------------------------
---- volumen ----
-----------------------------------
-- Subir volumen 5%
hl.bind(
	mainMod .. " + u",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5% && swayosd-client --output-volume raise"),
	{ repeating = true }
)

-- Bajar volumen 5%
hl.bind(
	mainMod .. " + y",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5% && swayosd-client --output-volume lower"),
	{ repeating = true }
)

-- Toggle mute + overlay
hl.bind(mainMod .. " + m", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { repeating = true })
