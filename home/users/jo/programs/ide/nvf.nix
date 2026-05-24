{
  self,
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.my.home.programs.ide.nvf;
in {
  options.my.home.programs.ide.nfv = {
    enable = mkEnableOption "Enable opinionated nvf setup";
  };
  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      settings.vim = {
        viAlias = true;
        vimAlias = true;

        options = {
          number = true;
          relativenumber = true;

          shiftwidth = 2;
          tabstop = 2;
          expandtab = true;

          smartindent = true;
          wrap = false;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };

        statusline.lualine.enable = true;

        telescope.enable = true;

        filetree.neo-tree.enable = true;

        treesitter = {
          enable = true;
          indent.enable = true;
        };

        autocomplete.nvim-cmp.enable = true;

        autopairs.nvim-autopairs.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        languages = {
          enableTreesitter = true;
          enableFormat = true;
          enableLSP = true;

          nix = {
            enable = true;

            format = {
              enable = true;
              type = "alejandra";
            };
            lint = {
              enable = true;
              package = pkgs.statix;
            };
          };
          go.enable = true;
          lua.enable = true;
        };
      };
    };
  };
}
