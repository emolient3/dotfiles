-- input.lua

hl.config({
	input = {
		-- kb_layout = "latam",
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,
		-- SENSIBILIDAD DEL MOUSE
		sensitivity = 1.0, -- -1.0 - 1.0, 0 means no modification.
		touchpad = {
			natural_scroll = false,
		},
	},
})

-- gestos para touchpad lap
-- hl.gesture({
--     fingers = 3,
--     direction = "horizontal",
--     action = "workspace",
-- })

-- Per-device config (ejemplo)
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
