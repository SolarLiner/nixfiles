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
  modifications = final: prev: {
    jetbrains-toolbox = prev.jetbrains-toolbox.overrideAttrs (oldAttrs: {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [prev.makeWrapper];
      postFixup = let
        binPath = lib.makeBinPath (with final; [python3 rustup cargo cmake ninja clang final.stdenv.cc.cc gdb lldb]);
      in ''
        wrapProgram $out/bin/jetbrains-toolbox \
          --set PATH ${binPath}
      '';
    });
    nushell = prev.nushell.overrideAttrs (old: {doCheck = false;});
    inetutils = prev.inetutils.overrideAttrs (old: {
      hardeningDisable = (old.hardeningDisable or []) ++ ["format"];
      postPatch =
        (old.postPatch or "")
        + ''
          # Remove ping-localhost from the test lists
            substituteInPlace tests/Makefile.am \
              --replace "dist_check_SCRIPTS += ping-localhost.sh" ""

            substituteInPlace tests/Makefile.in \
              --replace " ping-localhost.sh \\" " \\" \
              --replace " ping-localhost.sh" "" \
              --replace "@ENABLE_ping_TRUE@am__append_4 = ping-localhost.sh" "@ENABLE_ping_TRUE@am__append_4 =" \
              --replace "ping-localhost.sh.log: ping-localhost.sh" "" \
              --replace "ping-localhost.sh.log:" ""
        '';
    });
  };

  unstableModifications = mkUnstableOverlay ["plugdata" "yarnConfigHook" "dotnet-sdk"];

  # When applied, the unstable <C> (declaredC in the flake inputsC  where C: ops::Deref, C::Target: HasP  will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = mkUnstable final.system;
  };
}
