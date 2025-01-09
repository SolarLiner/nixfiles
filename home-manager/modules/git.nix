{
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    # Needed on Fedora to support GSSAPI patches
    package = pkgs.gitAndTools.gitFull.override ({ openssh = pkgs.openssh_gssapi; });
    enable = true;
    difftastic.enable = true;
    lfs.enable = true;
    extraConfig = {
      fetch.prune = true;
    };
  };
  programs.gh = {
    enable = lib.mkDefault true;
    settings = {
      prompt = "enabled";
      git_protocol = "ssh";
    };
  };
}
