#!/usr/bin/env bash
WALLPAPER_DIR="../../../../modules/themes/wallpapers/abstract"

# Pick a random image file (jpg or png)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) -exec realpath {} \; | shuf -n 1)

# Run hyprpaper with the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER" >>/dev/null
