# Start the graphical session after an interactive login on the primary local
# TTY. Other TTYs and SSH remain available as recovery paths.
export PATH="$HOME/.local/bin:$PATH"

if [[ -z "${WAYLAND_DISPLAY:-}" && -z "${DISPLAY:-}" && "${XDG_VTNR:-0}" == 1 ]]; then
  exec start-hyprland
fi
