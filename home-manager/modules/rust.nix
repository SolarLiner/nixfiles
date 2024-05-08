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
    #cargo-about
    cargo-audit
    cargo-bump
    cargo-expand
    cargo-flamegraph
    cargo-fuzz
    cargo-geiger
    cargo-generate
    cargo-insta
    cargo-release
    cargo-semver-checks
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
  xdg.configFile."environment.d/99-rustup.conf" = lib.mkIf (!stdenv.isDarwin) {
    text = ''
      CARGO_HOME=$HOME/.local/share/cargo
      PATH=$CARGO_HOME/bin:$PATH
    '';
  };
}
