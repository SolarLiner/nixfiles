# This file defines overlays
{
  inputs,
  lib,
  ...
}: let
  mkUnstable = system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
in {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    iosevka = prev.iosevka.overrideAttrs (oldAttrs: rec {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [final.nerd-font-patcher];
      postInstall = ''
        for file in $out/share/fonts/truetype/*.ttf; do
          nerd-font-patcher $file
        done
      '';
    });
    plugdata = (mkUnstable final.system).plugdata.overrideAttrs (oldAttrs: rec {
      version = "0.8.3";
      src = oldAttrs.src.overrideAttrs (old: {
        rev = "v${version}";
        sha256 = "";
      });
    });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = mkUnstable final.system;
  };
}
