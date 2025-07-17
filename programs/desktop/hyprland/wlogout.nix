{pkgs, ...}: let
  custom = {
    font = "Maple Mono";
    font_size = "15px";
    font_weight = "bold";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#928374";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    cyan = "#689D6A";
    orange = "#D65D0E";
    orange_bright = "#FE8019";
    opacity = "1";
    indicator_height = "2px";
  };
in {
  home-manager.sharedModules = [
    (_: {
      xdg.configFile."wlogout/icons".source = ./icons;
      programs.wlogout = {
        enable = true;
        layout = with custom; [
          {
            label = "lock";
            action = "${pkgs.hyprlock}/bin/hyprlock";
            text = "Lock";
            keybind = "l";
          }
          {
            label = "hibernate";
            action = "systemctl hibernate";
            text = "Hibernate";
            keybind = "h";
          }
          {
            label = "logout";
            action = "hyprctl dispatch exit 0";
            # action = "killall -9 Hyprland sleep 2";
            text = "Exit";
            keybind = "e";
          }
          {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
          }
          {
            label = "suspend";
            action = "systemctl suspend";
            text = "Suspend";
            keybind = "u";
          }
          {
            label = "reboot";
            action = "systemctl reboot";
            text = "Reboot";
            keybind = "r";
          }
        ];

        style = with custom; ''
          window {
            font-family: monospace;
            font-size: 14pt;
            color: ${text_color}; /* text */
            background-color: ${background_0};
          }

          button {
            background-repeat: no-repeat;
            background-position: center;
            background-size: 25%;
            border: ${border_color};
            background-color: ${background_0};
            margin: 5px;
            transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
          }

          button:hover {
            background-color: rgba(49, 50, 68, 0.1);
          }

          button:focus {
            background-color: #cba6f7;
            color: #1e1e2e;
          }
          #lock {
            background-image: image(url("./icons/lock.png"));
          }
          #lock:focus {
            background-image: image(url("./icons/lock-hover.png"));
          }

          #logout {
            background-image: image(url("./icons/logout.png"));
          }
          #logout:focus {
            background-image: image(url("./icons/logout-hover.png"));
          }

          #suspend {
            background-image: image(url("./icons/sleep.png"));
          }
          #suspend:focus {
            background-image: image(url("./icons/sleep-hover.png"));
          }

          #shutdown {
            background-image: image(url("./icons/power.png"));
          }
          #shutdown:focus {
            background-image: image(url("./icons/power-hover.png"));
          }

          #reboot {
            background-image: image(url("./icons/restart.png"));
          }
          #reboot:focus {
            background-image: image(url("./icons/restart-hover.png"));
          }
        '';
      };
    })
  ];
}
