-- windowrules.lua

------------------------------
---- EJEMPLOS COMENTADOS ----
------------------------------
-- hl.window_rule({ name = "example-float-kitty", match = { class = "^(kitty)$", title = "^(kitty)$" }, float = true })
-- hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })
-- hl.window_rule({
--     name = "fix-xwayland-drags",
--     match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })
-- hl.window_rule({ name = "steamwebhelper-float", match = { class = "steamwebhelper", fullscreen = true }, float = true })
-- hl.window_rule({ name = "stremio-float", match = { title = "Stremio", fullscreen = true }, float = true })

----------------------------------
---- BORDE EN FULLSCREEN ----
----------------------------------
hl.window_rule({
	name = "fullscreen-border-color",
	match = { fullscreen = true },
	border_color = "rgb(f47a80)",
})

------------------------------------------
---- VENTANAS FLOTANTES POR ATAJO ----
------------------------------------------
-- lanzado desde: bind = SUPER, Return, exec, ~/.local/bin/kitty-float
hl.window_rule({
	name = "kitty-float",
	match = { class = "floatkitty" },
	float = true,
	size = "800 464",
	center = true,
})

hl.window_rule({
	name = "config-window",
	match = { class = "config" },
	float = true,
	size = "1028 946",
	center = true,
})

hl.window_rule({
	name = "launcher-apps",
	match = { class = "launcher" },
	stay_focused = true,
	pin = true,
	center = true,
	size = "500 600",
	float = true,
})

-------------------------------
---- SIN BLUR (NOBLUR) ----
-------------------------------
hl.window_rule({
	name = "noblur-kitty-block",
	match = { class = "kitty" },
	no_blur = true,
})

-- ⚠️ Esta es básicamente redundante con la de arriba (ambas apuntan a kitty),
-- solo que esta es más específica (kitty SIN flotar). La dejo igual por fidelidad,
-- pero probablemente puedas borrar una de las dos.
hl.window_rule({
	name = "noblur-kitty-tiled",
	match = { class = "^(kitty)$", float = false },
	no_blur = true,
})
hl.window_rule({
	name = "noblur-steam-tiled",
	match = { class = "steam", float = false },
	no_blur = true,
})
hl.window_rule({
	name = "noblur-discord-tiled",
	match = { class = "discord", float = false },
	no_blur = true,
})

----------------------------------------
---- MONITOR SELECTOR / WALLPAPER ----
----------------------------------------
hl.window_rule({
	name = "monitorselector-focus",
	match = { title = "^(MonitorSelector)$" },
	stay_focused = true,
})
hl.window_rule({
	name = "monitorselector-float",
	match = { class = "(python3)", title = "^(MonitorSelector)*" },
	float = true,
})
hl.window_rule({
	name = "launcher-wallpaper-float",
	match = { class = "^(launcher_wallpaper)$" },
	float = true,
})
