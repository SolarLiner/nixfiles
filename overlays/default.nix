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
  nixgl = inputs.nixgl.overlay;
  # This one brings our custom packages from the 'pkgs' directory
  additions = _final: prev:
    import ../pkgs {
      inherit inputs;
      pkgs = prev;
    };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    plugdata = (mkUnstable final.system).plugdata;
    jetbrains-toolbox = prev.jetbrains-toolbox.overrideAttrs (oldAttrs: {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [prev.makeWrapper];
      postFixup = let
        binPath = lib.makeBinPath (with final; [python3 rustup cargo cmake ninja clang final.stdenv.cc.cc gdb lldb]);
      in ''
        wrapProgram $out/bin/jetbrains-toolbox \
          --set PATH ${binPath}
      '';
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = mkUnstable final.system;
  };
}
