-- look.lua

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 7,
		border_size = 1,
		col = {
			active_border = "rgb(1EA8BA)",
			inactive_border = "rgb(4f4f4f)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 2,
		active_opacity = 1,
		inactive_opacity = 1,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a, -- rgba(1a1a1aee) en formato hex ARGB de lua
		},
		blur = {
			enabled = false,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true, -- antes: "yes, please :)" (easter egg de hyprlang, en lua es simplemente true)
	},
})

----------------------------
---- CURVAS Y ANIMACIONES ----
----------------------------
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

----------------------
---- LAYOUTS ----
----------------------
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

----------------
---- MISC ----
----------------
hl.config({
	misc = {
		force_default_wallpaper = -1, -- 0 o 1 para desactivar los wallpapers del mascota anime
		disable_hyprland_logo = false,
	},
})

----------------------------------
---- BLUR GLOBAL (DETALLADO) ----
----------------------------------
-- ⚠️⚠️ CONFLICTO IMPORTANTE: en look.lua ya pusimos blur.enabled = false.
-- Aquí en tu .conf original lo estabas reactivando con `decoration:blur:enabled = true`
-- usando la sintaxis "keyword" (que en hyprlang sobreescribe lo anterior porque se
-- procesa después en el archivo). En Lua, NO sé con certeza si dos llamadas a
-- hl.config({decoration=...}) se mezclan o si la segunda pisa completo a la primera.
-- Para evitar el problema de raíz: BORRA el bloque blur={} de look.lua y deja
-- SOLO este de aquí, que es el que realmente quieres activo (con todos los detalles).
hl.config({
	decoration = {
		blur = {
			enabled = true,
			size = 5,
			passes = 2,
			ignore_opacity = true,
			new_optimizations = true,
			xray = false,
			noise = 0.03, -- granulado
			brightness = 0.8172,
			vibrancy = 0.5,
			vibrancy_darkness = 0.1,
			special = false,
			popups = true,
			popups_ignorealpha = 0.2,
			input_methods = true,
			input_methods_ignorealpha = 1,
		},
	},
})

-------------------------------
---- OPACIDAD POR APP ----
-------------------------------
hl.window_rule({ name = "opacity-zen", match = { class = "^(zen)$" }, opacity = "0.9 0.9" })
hl.window_rule({ name = "opacity-steam", match = { class = "^(steam)$" }, opacity = "0.94 0.94" })
hl.window_rule({ name = "opacity-discord", match = { class = "^(discord)$" }, opacity = "1 1" })
hl.window_rule({ name = "opacity-spotify", match = { class = "^(Spotify)$" }, opacity = "0.78 0.78" })
hl.window_rule({
	name = "opacity-whatsapp",
	match = { class = "^(chrome-web.whatsapp.com__-Default)$" },
	opacity = "1.0 1.0",
})
hl.window_rule({
	name = "opacity-chatgpt-tab",
	match = { title = "(ChatGPT — Mozilla Firefox)" },
	opacity = "0.8 0.8",
})
hl.window_rule({ name = "opacity-x-tab", match = { title = "(Inicio / X — Mozilla Firefox)" }, opacity = "0.8 0.8" })
