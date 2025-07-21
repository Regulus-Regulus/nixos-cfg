{pkgs, ...}: {
  fonts.packages = with pkgs.nerd-fonts; [jetbrains-mono];
  home-manager.sharedModules = [
    (_: {
      programs.kitty = {
        enable = true;
        extraConfig = ''
          font_features MapleMono-Regular +ss01 +ss02 +ss04
          font_features MapleMono-Bold +ss01 +ss02 +ss04
          font_features MapleMono-Italic +ss01 +ss02 +ss04
          font_features MapleMono-Light +ss01 +ss02 +ss04
          disable_opengl yes
          vsync yes
          env EGL_PLATFORM=wayland
          env LIBGL_ALWAYS_INDIRECT=1
        '';
        shellIntegration.enableZshIntegration = true;
        themeFile = "gruvbox-dark-hard";
        settings = {
          confirm_os_window_close = 0;
          scrollback_lines = 10000;
          enable_audio_bell = false;
          mouse_hide_wait = 60;
          window_padding_width = 10;

          ## Tabs
          tab_title_template = "{index}";
          active_tab_font_style = "normal";
          inactive_tab_font_style = "normal";
          tab_bar_style = "powerline";
          tab_powerline_style = "angled";
          active_tab_foreground = "#FBF1C7";
          active_tab_background = "#7C6F64";
          inactive_tab_foreground = "#FBF1C7";
          inactive_tab_background = "#3C3836";
          # shell = "${getExe pkgs.tmux}";
          # cursor_trail = 3; # Fancy cursor movements (especially in nixvim)
          # cursor_trail_decay = "0.08 0.3"; # Animation speed
          # cursor_trail_start_threshold = "4";
          strip_trailing_spaces = "smart";
          macos_option_as_alt = "yes";
          macos_quit_when_last_window_closed = true;
          copy_on_select = "yes";
          update_check_interval = 0;
        };
        # shellIntegration.mode = "no-sudo";
        keybindings = {
          "ctrl+alt+n" = "launch --cwd=current";
          "alt+w" = "copy_and_clear_or_interrupt";
          "ctrl+y" = "paste_from_clipboard";
          # "alt+1" = "goto_tab 1";
          # "alt+2" = "goto_tab 2";
          # "alt+3" = "goto_tab 3";
          # "alt+4" = "goto_tab 4";
          # "alt+5" = "goto_tab 5";
          # "alt+6" = "goto_tab 6";
          # "alt+7" = "goto_tab 7";
          # "alt+8" = "goto_tab 8";
          # "alt+9" = "goto_tab 9";
          # "alt+0" = "goto_tab 10";

          # Tmux
          # "ctrl+t" = "launch --cwd=current --type=overlay tmux-sessionizer";
          # "ctrl+t" = "launch --cwd=current --title tmux-sessionizer tmux-sessionizer";
          # "ctrl+shift+left" = "no_op";
          # "ctrl+shift+right" = "no_op";
        };
      };
    })
  ];
}
