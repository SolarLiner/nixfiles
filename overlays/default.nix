# This file defines overlays
{
  inputs,
  lib,
  ...
}: let
  fixMissingMaintainers = pkg:
    pkg.overrideAttrs (final: prev: {
      meta =
        prev.meta
        // {
          maintainers = ({maintainers = [];} // prev.meta).maintainers ++ lib.lists.concatMap (t: t.members) final.meta.teams;
        };
    });
  mkUnstable = system:
    import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        # TEMP: Fixing the issue of missing maintainers by setting it ourselves
        (final: prev: {neovim-unwrapped = fixMissingMaintainers prev.neovim-unwrapped;})
      ];
    };
  mkUnstableOverlay = packages: final: _prev: lib.attrsets.genAttrs packages (name: final.unstable.${name});
in {
  # This one brings our custom packages from the 'pkgs' directory
  additions = _final: prev:
    import ../pkgs {
      inherit inputs;
      pkgs = prev;
    };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {};

  unstableModifications = mkUnstableOverlay [];

  # When applied, the unstable <C> (declaredC in the flake inputsC  where C: ops::Deref, C::Target: HasP  will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = mkUnstable final.system;
  };
}
