{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs) stdenv;
in {
  home.packages = with pkgs; [
    rustup
    mold
    bacon
    cargo-about
    cargo-audit
    cargo-bump
    cargo-expand
    cargo-flamegraph
    cargo-fuzz
    cargo-generate
    cargo-insta
    cargo-release
    cargo-semver-checks
    cargo-update
    cargo-watch
    cargo-wipe
  ];
  programs.zsh.initExtra = lib.mkIf stdenv.isDarwin ''
    export CARGO_HOME=$HOME/.cargo
    export PATH=$CARGO_HOME/bin:$PATH
  '';
  xdg.configFile."cargo/config".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker="clang"
    rustflags = [
        "-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold",
    ]
  '';
home.sessionVariables = {
  CARGO_HOME = "$HOME/.local/share/cargo";
};
home.sessionPath = ["$CARGO_HOME/bin"];
}
