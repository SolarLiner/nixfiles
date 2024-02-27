{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.google-drive-ocamlfuse;
in {
  options.services.google-drive-ocamlfuse = {
    enable = mkEnableOption "Google Drive";
    package = mkPackageOption pkgs "google-drive-ocamlfuse" {};
    folder = mkOption {
      type = types.str;
      default = "Google Drive";
      description = "Target folder for the mount point of the Google Drive share.";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.google-drive-ocamlfuse = {
      Unit = {
        description = "Google Drive FUSE mount";
        After = ["network.target"];
      };
      Install.WantedBy = ["default.target"];
      Service = let
        mkdir = "${pkgs.coreutils}/bin/mkdir";
        fusermount = "${pkgs.fuse}/bin/fusermount";
        rmdir = "${pkgs.coreutils}/bin/rmdir";
        google-drive-ocamlfuse = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse";
        folder = "%h/${cfg.folder}";
      in {
        ExecStartPre = "${mkdir} -p '${folder}'";
        ExecStart = "${google-drive-ocamlfuse} '${folder}'";
        ExecStop = "${fusermount} -u '${folder}'";
        ExecStopPost = "${rmdir} '${folder}' || exit 0";
        Restart = "always";
        Type = "forking";
      };
    };
  };
}
