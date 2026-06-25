#!/usr/bin/env python3
"""
float_small_windows_fixed_size.py

Hyprland helper:
- On 'openwindow', waits ~0.8s, then checks window size.
- If window is smaller than 900x600 in either dimension:
  -> set floating, resize to 1920x1080, move near center with jitter.
- If both dimensions are >=900x600, leave it tiled.
- Terminal classes are ignored.

Updated for Hyprland 0.55+ using hyprctl eval + hl.dispatch() Lua native syntax.
"""

import subprocess, json, socket, re, sys, os, random, time

# ---------------- CONFIG ----------------
MIN_W = 900
MIN_H = 600
WAIT_BEFORE_CHECK = 0   # seconds to wait after openwindow
RESIZE_W = 1200           # fixed resize width for small windows
RESIZE_H = 800           # fixed resize height for small windows
TERMINAL_CLASSES = [
    "kitty", "alacritty", "foot", "gnome-terminal", "konsole",
    "xterm", "urxvt", "st", "terminator"
]
# ----------------------------------------

def get_socket_path():
    sig = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE", "")
    uid = os.getuid()
    base = f"/run/user/{uid}/hypr"
    if sig:
        candidate = f"{base}/{sig}/.socket2.sock"
        if os.path.exists(candidate):
            return candidate
    if os.path.isdir(base):
        for entry in os.listdir(base):
            candidate = os.path.join(base, entry, ".socket2.sock")
            if os.path.exists(candidate):
                return candidate
    raise FileNotFoundError("Could not locate Hyprland .socket2.sock")

def hyprctl_clients_json():
    try:
        out = subprocess.check_output(["hyprctl", "-j", "clients"], stderr=subprocess.DEVNULL)
        return json.loads(out)
    except Exception:
        return []

def parse_size(client):
    s = client.get("size")
    if isinstance(s, (list, tuple)) and len(s) >= 2:
        try:
            return int(s[0]), int(s[1])
        except Exception:
            return None, None
    if isinstance(s, str):
        m = re.findall(r"\d+", s)
        if len(m) >= 2:
            return int(m[0]), int(m[1])
    return None, None

def is_terminal_class(client):
    cls = (client.get("class") or client.get("initialClass") or "").lower()
    return any(t.lower() == cls for t in TERMINAL_CLASSES)

def normalize_address(a):
    if not a:
        return ""
    a = str(a)
    if a.startswith("0x"):
        return a.lower()
    else:
        return "0x" + a.lower().lstrip("0x")

def hyprctl_eval(lua_expr):
    """
    Hyprland 0.55+: ejecuta Lua directamente en el compositor.
    Usa 'hyprctl eval' en lugar de 'hyprctl dispatch' para poder
    usar la API Lua nativa completa con hl.dispatch().
    """
    try:
        result = subprocess.run(
            ["hyprctl", "eval", lua_expr],
            check=False,
            capture_output=True,
            text=True
        )
        if result.returncode != 0 or "error" in result.stdout.lower():
            print(f"Hyprctl eval error: {result.stdout.strip()} | {result.stderr.strip()}")
    except Exception as e:
        print("Eval error:", e)

def dispatch_float(address):
    """setfloating -> hl.dsp.window.float({ action = "set", window = "address:..." })"""
    hyprctl_eval(f'hl.dispatch(hl.dsp.window.float({{ action = "set", window = "address:{address}" }}))')

def dispatch_resize(address, w, h):
    """resizewindowpixel exact -> hl.dsp.window.resize({ x=W, y=H, exact=true, window="address:..." })"""
    hyprctl_eval(f'hl.dispatch(hl.dsp.window.resize({{ x = {w}, y = {h}, exact = true, window = "address:{address}" }}))')

def dispatch_move(address, x, y):
    """movewindowpixel exact -> hl.dsp.window.move({ x=X, y=Y, exact=true, window="address:..." })"""
    hyprctl_eval(f'hl.dispatch(hl.dsp.window.move({{ x = {x}, y = {y}, exact = true, window = "address:{address}" }}))')

def find_client_by_address(addr):
    want = normalize_address(addr)
    clients = hyprctl_clients_json()
    for c in clients:
        if normalize_address(c.get("address")) == want:
            return c
    return None

def get_active_monitor():
    try:
        out = subprocess.check_output(["hyprctl", "-j", "monitors"], stderr=subprocess.DEVNULL)
        mons = json.loads(out)
        for m in mons:
            if m.get("focused"):
                return m
        return mons[0] if mons else None
    except Exception:
        return None

def move_window_natural(address, new_w, new_h):
    mon = get_active_monitor()
    if not mon:
        return
    mw, mh = mon["width"], mon["height"]
    mx, my = mon["x"], mon["y"]
    # base: centered
    cx = mx + (mw - new_w) // 2
    cy = my + (mh - new_h) // 2
    # jitter: stronger horizontally
    jitter_x = int(mw * 0.10)   # ±10% horizontal
    jitter_y = int(mh * 0.05)   # ±5% vertical
    cx += random.randint(-jitter_x, jitter_x)
    cy += random.randint(-jitter_y, jitter_y)
    dispatch_move(address, cx, cy)

def handle_openwindow(payload):
    addr = payload.split(",", 1)[0].strip()
    if not addr:
        return
    addr_norm = normalize_address(addr)

    # wait a bit for the window to stabilize
    time.sleep(WAIT_BEFORE_CHECK)

    client = find_client_by_address(addr_norm)
    if not client:
        return
    if is_terminal_class(client):
        return
    if client.get("floating"):
        return

    w, h = parse_size(client)
    if w is None or h is None:
        return

    if w < MIN_W or h < MIN_H:
        a = normalize_address(client.get("address"))
        if not a:
            return
        dispatch_float(a)
        new_w, new_h = RESIZE_W, RESIZE_H
        dispatch_resize(a, new_w, new_h)
        move_window_natural(a, new_w, new_h)
        print(f"[applied] {client.get('class')} '{client.get('title')}' {w}x{h} -> {new_w}x{new_h}")
    else:
        print(f"[ignored] {client.get('class')} '{client.get('title')}' {w}x{h} (already big enough)")

def main():
    try:
        sock_path = get_socket_path()
    except FileNotFoundError as e:
        print("No se encontró socket de Hyprland:", e)
        sys.exit(1)

    try:
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.connect(sock_path)
        print("Connected to:", sock_path)
    except Exception as e:
        print("Could not connect to Hyprland socket:", e)
        sys.exit(1)

    try:
        while True:
            data = s.recv(4096).decode("utf-8", errors="ignore")
            if not data:
                time.sleep(0.05)
                continue
            for line in data.strip().split("\n"):
                if ">>" not in line:
                    continue
                ev, payload = line.split(">>", 1)
                if ev.strip() == "openwindow":
                    handle_openwindow(payload.strip())
    except KeyboardInterrupt:
        print("Interrupted, exiting.")
    finally:
        try:
            s.close()
        except Exception:
            pass

if __name__ == "__main__":
    main()
