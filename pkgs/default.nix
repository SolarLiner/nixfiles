# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
  pkgs,
  inputs,
}:
with pkgs; {
  # Clean setup script: clones the repository and activates the system configuration
  # (which includes home-manager). Run with `nix run github:solarliner/nixfiles#bootstrap`.
  # Set SYSTEM to override the configuration name (defaults to the hostname).
  bootstrap = writeShellApplication {
    name = "bootstrap";
    runtimeInputs =
      [git just nix-output-monitor]
      ++ lib.optional stdenv.isDarwin inputs.nix-darwin.packages.${stdenv.hostPlatform.system}.darwin-rebuild
      ++ lib.optional stdenv.isLinux nixos-rebuild;
    text = ''
      NIXFILES_DIR="''${NIXFILES_DIR:-$HOME/.config/nixfiles}"
      if [ ! -d "$NIXFILES_DIR/.git" ]; then
        mkdir -p "$(dirname "$NIXFILES_DIR")"
        git clone https://github.com/solarliner/nixfiles.git "$NIXFILES_DIR"
      fi
      export OUTPUT_MONITOR="''${OUTPUT_MONITOR:-nom --json}"
      just --justfile "$NIXFILES_DIR/Justfile" switch
    '';
  };
  clangd = callPackage ./clangd.nix {};
  kos-language-server = callPackage ./kos-language-server.nix {};
  wgsl-analyzer = callPackage ./wgsl-analyzer.nix {};
  tracy_0_9_1 = callPackage ./tracy_0_9_1.nix {};
}
