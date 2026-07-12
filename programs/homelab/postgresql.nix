{
  self,
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.programs.homelab.postgresql;
in {
  options.my.programs.homelab.postgresql = {
    enable = lib.mkEnableOption "Shared Postgres";
    databases = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule ({config, ...}: {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
          };

          user = lib.mkOption {
            type = lib.types.str;
            default = config.name;
          };
          owner = mkOption {
            type = types.bool;
            default = true;
          };
        };
      }));

      default = [];
      description = "Databases to provision.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_18;
      ensureDatabases =
        map (db: db.name) cfg.databases;
      settings.listen_addresses = "localhost";

      ensureUsers =
        map (db: {
          name = db.user;
          ensureDBOwnership = db.owner;
        })
        cfg.databases;
    };
  };
}
