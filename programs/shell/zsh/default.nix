{
  self,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;

  home-manager.sharedModules = [
    (_: {
      programs.zsh = {
        #enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        history = {
          size = 100000;
          path = "$HOME/.local/share/zsh/history";
        };
        dotDir = ".config/zsh";
        # initContent = ''
        #   source ${pkgs.spaceship-prompt}/share/zsh/themes/spaceship.zsh-theme;
        # '';
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" "gitignore" "z" ];
          theme = "pure";
        };
        shellAliases = {
          cls = "clear";
          update-input = "nix flake update $@";
          nrbuild = "sudo nixos-rebuild switch --flake ~/NixosConfiguration#laptop";
        };
      };
    })
  ];
}




# {
#   self,
#   pkgs,
#   ...
# }: {
#   home-manager.sharedModules = [
#     (_: {
#       programs.zsh = {
#         enable = true;
#         autosuggestion.enable = true;
#         syntaxHighlighting.enable = true;
#         enableCompletion = true;
#         history.size = 100000;
#         history.path = "$HOME/.local/share/zsh/history";
#         dotDir = ".config/zsh";
#         initContent = ''
#           source ${pkgs.spaceship-prompt}/share/zsh/themes/spaceship.zsh-theme;
#         '';
#         oh-my-zsh = {
#           enable = true;
#           plugins = [
#             "git"
#             "gitignore"
#             "z"
#           ];
#         };
#         shellAliases = {
#           cls = "clear";
#           # tml = "tmux list-sessions";
#           # attach = "tmux attach";
#           # att = "tmux attach";
#           # l = "${pkgs.eza}/bin/eza -lh  --icons=auto"; # long list
#           # ls = "${pkgs.eza}/bin/eza -1   --icons=auto"; # short list
#           # ll = "${pkgs.eza}/bin/eza -lha --icons=auto --sort=name --group-directories-first"; # long list all
#           # ld = "${pkgs.eza}/bin/eza -lhD --icons=auto"; # long list dirs
#           # tree = "${pkgs.eza}/bin/eza --icons=auto --tree"; # dir tree
#           # vc = "code --disable-gpu"; # gui code editor
#           # nv = "nvim";
#           # nf = "${pkgs.microfetch}/bin/microfetch";
#           # cp = "cp -iv";
#           # mv = "mv -iv";
#           # rm = "rm -vI";
#           # bc = "bc -ql";
#           # mkd = "mkdir -pv";
#           # tp = "${pkgs.trash-cli}/bin/trash-put";
#           # tpr = "${pkgs.trash-cli}/bin/trash-restore";
#           # grep = "grep --color=always";
#           # pokemon = "pokego --random 1-8 --no-title";

#           # Nixos
#           # list-gens = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system/";
#           # find-store-path = ''function { nix-shell -p $1 --command "nix eval -f \"<nixpkgs>\" --raw $1" }'';
#           update-input = "nix flake update $@";
#           nrbuild = "sudo nixos-rebuild switch --flake ~/NixosConfiguration#laptop";
#           # sysup = "sudo nixos-rebuild switch --flake ~/NixOS#Default --upgrade-all --show-trace";

#           # Directory Shortcuts.
#           # dots = "cd ~/nix-config/";
#           # games = "cd /mnt/games/";
#           # work = "cd ~/Work/";
#           # media = "cd /mnt/ntfsdrive/Media Files/";
#           # projects = "cd ~/Projects/";
#           # dev = "cd /mnt/work/Projects/";
#           # dev = "cd /mnt/work/dev/";
#           # nixdir = "cd /mnt/work/dev/nix/";
#           # cppdir = "cd /mnt/work/dev/C++/";
#           # zigdir = "cd /mnt/work/dev/Zig/";
#           # csdir = "cd /mnt/work/dev/C#/";
#           # rustdir = "cd /mnt/work/dev/Rust/";
#           # pydir = "cd /mnt/work/dev/Python/";
#           # javadir = "cd /mnt/work/dev/Java/";
#           # luadir = "cd /mnt/work/dev/lua/";
#           # webdir = "cd /mnt/work/dev/Website/";
#         };
#       };
#     })
#   ];
# }