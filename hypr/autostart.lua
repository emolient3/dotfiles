-- autostart.lua

hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("systemctl --user start swayosd.service") -- servicio overlay sonido
	hl.exec_cmd("/home/cali/.local/bin/hyprbars-terminal")
	hl.exec_cmd("discord --start-minimized")
	hl.exec_cmd("steam --start-minimized -silent")

	-- hl.exec_cmd('[workspace special:magic silent] spotify')
	-- hl.exec_cmd('[workspace special:magic silent] gtk-launch whatsapp.desktop')
	-- hl.exec_cmd("hyprpanel") -- pkill gjs
	-- hl.exec_cmd("firefox")
end)

hl.on("hyprland.start", function()
	hl.exec_cmd("python3 /home/cali/.config/hypr/scripts/float_small_windows.py &")
end)
