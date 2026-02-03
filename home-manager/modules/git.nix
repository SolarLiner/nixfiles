{
  pkgs,
  lib,
  ...
}: {
  programs.difftastic = {
    enable = true;
    git.enable = true;
  };
  programs.git = {
    # Needed on Fedora to support GSSAPI patches
    package = pkgs.gitFull.override {openssh = pkgs.openssh_gssapi;};
    enable = true;
    lfs.enable = true;
    settings.fetch.prune = true;
  };
  programs.gh = {
    enable = lib.mkDefault true;
    settings = {
      prompt = "enabled";
      git_protocol = "ssh";
    };
  };
  programs.lazygit.enable = true;
}
