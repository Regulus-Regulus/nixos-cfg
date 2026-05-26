{
  self,
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  cfg = config.jo.home.programs.ide.nvf;
in {
  options.jo.home.programs.ide.nvf = {
    enable = mkEnableOption "Enable opinionated nvf setup";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      statix
      deadnix
    ];

    stylix.targets.vim.enable = false;
    stylix.targets.nvf.enable = false;
    stylix.targets.neovim.enable = false;

    programs.nvf = {
      enable = true;

      settings.vim = {
        luaConfigRC.terminal_setup = ''
          vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "*",
            callback = function()
              vim.cmd("startinsert")
            end,
          })
        '';
        globals = {
          loaded_netrw = 1;
          loaded_netrwPlugin = 1;
        };
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

        theme = lib.mkForce {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        statusline.lualine.enable = true;

        telescope.enable = true;

        filetree.neo-tree = {
          enable = true;

          setupOpts = {
            filesystem = {
              hijack_netrw_behavior = "open_default";
              followCurrentFile.enabled = true;
            };
          };
        };

        diagnostics.nvim-lint = {
          enable = true;

          lint_after_save = true;

          linters_by_ft = {
            nix = ["statix" "deadnix"];
          };
        };
        extraPlugins = {
          rainbow-delimiters = {
            package = pkgs.vimPlugins.rainbow-delimiters-nvim;
          };
        };

        luaConfigRC.rainbow-delimiters = ''
          require("rainbow-delimiters.setup").setup {}
        '';
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
          helm.enable = true;
          nix = {
            enable = true;

            format = {
              enable = true;
              type = ["alejandra"];
            };
          };
          go.enable = true;
          lua.enable = true;
        };
      };
    };
  };
}
