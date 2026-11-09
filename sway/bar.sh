#!/bin/bash

# ==============================
# CONFIG
# ==============================

# Network interface
# iface="wlan0"

# Battery information path
battery_path="/sys/class/power_supply/BAT0"


# ==============================
# FUNCTIONS
# ==============================

# Get RAM usage in GB
# Returns:
#   used total
get_ram() {
    free -m | awk '/Mem:/ {printf "%.1f %.1f", $3/1024, $2/1024}'
}


# Get SWAP usage in GB
# Returns:
#   used total
get_swap() {
    free -m | awk '/Swap:/ {printf "%.1f %.1f", $3/1024, $2/1024}'
}


# ==============================
# CPU FUNCTIONS
# ==============================

# Get CPU usage percentage
# get_cpu() {
#     awk -v RS="" '{printf "%.0f", ($2+$4)*100/($2+$4+$5)}' /proc/stat
# }


# Get CPU temperature
# get_cpu_temp() {
#     if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
#         temp=$(cat /sys/class/thermal/thermal_zone0/temp)
#         temp=$((temp / 1000))
#     else
#         temp=$(sensors | awk '/Package id 0/ {print $4}' | tr -d '+°C')
#     fi

#     if [ "$temp" -lt 40 ]; then
#         color="#4caf50"
#     elif [ "$temp" -le 70 ]; then
#         color="#ffffff"
#     else
#         color="#f44336"
#     fi

#     echo "$temp°C|$color"
# }


# ==============================
# BATTERY
# ==============================

# Get battery percentage, charging status, and color
get_battery() {
    if [ -d "$battery_path" ]; then
        bat=$(cat "$battery_path/capacity")
        status=$(cat "$battery_path/status")

        # Use green when charging
        if [ "$status" = "Charging" ]; then
            icon="bat (charging):"
            color="#4caf50"
        else
            # Use red when battery is below 20%
            [ "$bat" -lt 20 ] && color="#f44336" && icon="bat (Low Bat):"

            # Use white when battery is 20% or higher
            [ "$bat" -ge 20 ] && color="#ffffff" && icon="bat:"
        fi

        echo "$icon $bat%|$color"
    else
        # Battery information is unavailable
        echo "N/A|#ffffff"
    fi
}


# ==============================
# SYSTEM INFORMATION
# ==============================

# Get the current Linux kernel version
kernel=$(uname -r)

# Get the current Shell and its version
shell_version=$("$SHELL" --version | awk 'NR==1 {print $1, $2}')


# ==============================
# AUDIO
# ==============================

Get current volume and mute status
get_volume() {
    if command -v wpctl >/dev/null; then
        vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2*100}')
        wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && muted=1 || muted=0
    else
        vol=$(pamixer --get-volume)
        pamixer --get-mute && muted=1 || muted=0
    fi

    [ "$muted" = "1" ] && icon="󰖁" || icon="󰕾"

    echo "$icon $vol%"
}


# ==============================
# NETWORK
# ==============================

# Get Wi-Fi SSID and connection status
# get_wifi() {
#     ssid=$(iw dev "$iface" link 2>/dev/null | awk -F': ' '/SSID/ {print $2}')

#     if [ -n "$ssid" ]; then
#         echo "󰖩 $ssid|#4caf50"
#     else
#         echo "󰖪 Disconnected|#f44336"
#     fi
# }


# ==============================
# KEYBOARD LAYOUT
# ==============================

# Get the active keyboard layout
# get_layout() {
#     swaymsg -t get_inputs | jq -r \
#         '.[] | select(.type=="keyboard") | .xkb_active_layout_name' | head -n1
# }


# ==============================
# MAIN LOOP
# ==============================

while :; do

    # cpu=$(get_cpu)

    # ==============================
    # RAM
    # ==============================

    # Get used and total RAM
    read used total <<< $(get_ram)

    # Calculate RAM usage percentage
    ram_percent=$(awk -v u="$used" -v t="$total" 'BEGIN {
        printf "%d", (u/t)*100
    }')


    # ==============================
    # SWAP
    # ==============================

    # Get used and total SWAP
    read swap_used swap_total <<< $(get_swap)

    # Calculate SWAP usage percentage
    swap_percent=$(awk -v u="$swap_used" -v t="$swap_total" 'BEGIN {
        if (t > 0)
            printf "%d", (u/t)*100
        else
            printf "0"
    }')


    # IFS="|" read cpu_temp cpu_temp_color <<< $(get_cpu_temp)

    # Get battery text and color
    IFS="|" read bat_text bat_color <<< $(get_battery)

    vol_text=$(get_volume)

    # IFS="|" read wifi_text wifi_color <<< $(get_wifi)

    # layout=$(get_layout)

    # date=$(date "+%a - %d %b %Y - %-I:%M %p")

    # Get current date and time
    date=$(date)


    # ==============================
    # OUTPUT
    # ==============================

    echo "<span foreground='#C2D099'><b><u>${date}</u></b></span> | \
<span foreground='${bat_color}'><b><u>${bat_text}</u></b></span> | \
<span foreground='#459180'><b><u>vol: ${vol_text}</u></b></span> | \
<span foreground='#7DA78C'><b><u>mem: ${used}G/${total}G (${ram_percent}%)</u></b></span> | \
<span foreground='#21904a'><b><u>swap: ${swap_used}G/${swap_total}G (${swap_percent}%)</u></b></span> | \
<span foreground='#bbbc00'><b><u>shell: ${shell_version}</u></b></span> | \
<span foreground='#C19A6B'><b><u>linux: ${kernel}</u></b></span> | \
<span foreground='#E6EEC9' font_desc='Iosevka 12'><b> </b></span>"


    # Update every second
    sleep 1


    # ==============================
    # OLD OUTPUT
    # ==============================

    # echo "<span foreground='#cdb444'>${date}</span> | \
    # <span foreground='#ff9800'>CPU ${cpu}%</span> - \
    # <span foreground='${cpu_temp_color}'>🌡 ${cpu_temp}</span> - \
    # <span foreground='#2196f3'>RAM ${used}G/${total}G (${ram_percent}%)</span> - \
    # <span foreground='${bat_color}'>${bat_text}</span> - \
    # <span foreground='#ffd500'>${vol_text}</span> | \
    # <span foreground='${wifi_color}'>${wifi_text}</span> | \
    # <span foreground='#00ffff'>⌨ ${layout}</span> | \
    # <span foreground='#ffffff' font_desc='Iosevka 12'><b> </b></span>"

done
