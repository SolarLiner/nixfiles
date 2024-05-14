# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
  pkgs,
  inputs,
}: let
  home-manager = inputs.home-manager.packages.${pkgs.system}.home-manager;
in
  with pkgs; {
    bootstrap = writeShellApplication {
      name = "bootstrap";
      runtimeInputs = [git gnumake home-manager];
      text = ''
        NIXFILES_DIR=$HOME/.config/nixfiles
        mkdir -p "$NIXFILES_DIR"
        git clone https://github.com/solarliner/nixfiles.git "$NIXFILES_DIR"
        make -C "$NIXFILES_DIR" home
      '';
    };
    clangd = callPackage ./clangd.nix {};
    extraVimPlugins = callPackage ./vimPlugins {};
    iosevka-nerd-fonts = callPackage ./iosevka.nix {};
    wgsl-analyzer = callPackage ./wgsl-analyzer.nix {};
    tracy_0_9_1 = callPackage ./tracy_0_9_1.nix {};
  }
