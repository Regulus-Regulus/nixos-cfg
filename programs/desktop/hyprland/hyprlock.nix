{...}: let
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
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            hide_cursor = true;
          };

          background = [
            {
              monitor = "";
              color = "rgb(36, 39, 58)";
              # path = "${../../../../themes/wallpapers/dark-forest.jpg}";

              new_optimizations = true;
              blur_size = 3;
              blur_passes = 2;
              noise = 0.0117;
              contrast = 1.000;
              brightness = 1.0000;
              vibrancy = 0.2100;
              vibrancy_darkness = 0.0;
            }
          ];

          input-field = [
            {
              monitor = "";
              size = "250, 50";
              outline_thickness = 3;
              outer_color = "rgb(198, 160, 246)";
              inner_color = "rgb(36, 39, 58)";
              font_color = "rgb(198, 160, 246)";
              fail_color = "rgb(237, 135, 150)";
              fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
              fail_transition = 300;
              fade_on_empty = false;
              placeholder_text = "Password...";
              dots_size = 0.2;
              dots_spacing = 0.64;
              dots_center = true;
              position = "0, 140";
              halign = "center";
              valign = "bottom";
            }
          ];

          label = [
            {
              monitor = "";
              # text = "cmd[update:1000] echo \"<b><big> $(date +\"%H:%M:%S\") </big></b>\"";
              text = "$TIME";
              font_size = 64;
              font_family = "JetBrains Mono Nerd Font 10";
              color = "rgb(198, 160, 246)";
              position = "0, 16";
              valign = "center";
              halign = "center";
            }
            {
              monitor = "";
              text = "Hello <span text_transform=\"capitalize\" size=\"larger\">$USER!</span>";
              color = "rgb(198, 160, 246)";
              font_size = 20;
              font_family = "JetBrains Mono Nerd Font 10";
              position = "0, 100";
              halign = "center";
              valign = "center";
            }
            {
              monitor = "";
              text = "Password Required";
              color = "rgb(198, 160, 246)";
              font_size = 14;
              font_family = "JetBrains Mono Nerd Font 10";
              position = "0, 20";
              halign = "center";
              valign = "bottom";
            }
            /*
               {
              monitor = "";
              text = "Enter your password to unlock.";
              color = "rgb(198, 160, 246)";
              font_size = 14;
              font_family = "JetBrains Mono Nerd Font 10";
              position = "0, 60";
              halign = "center";
              valign = "bottom";
            }
            */
          ];
        };
      };
    })
  ];
}
