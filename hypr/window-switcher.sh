#!/usr/bin/env bash
# ~/.config/hypr/window-switcher.sh
set -euo pipefail

# obtener clientes en JSON
clients_json=$(hyprctl clients -j 2>/dev/null) || exit 1

# generar lista: address <tab> title
list=$(jq -r '.[] | select(.mapped == true) | "\(.address)\t\(.title // "(no title)")"' <<<"$clients_json")

# si no hay ventanas, salir
[ -z "$list" ] && exit 0

# elegir con wofi (dmenu mode)
selection=$(printf '%s\n' "$list" | wofi --show dmenu --prompt "Ventanas:")

# si canceló, salir
[ -z "$selection" ] && exit 0

# extraer address (antes del tab)
address=$(printf '%s' "$selection" | cut -f1)

# enfocar la ventana elegida
hyprctl dispatch focuswindow address:$address

