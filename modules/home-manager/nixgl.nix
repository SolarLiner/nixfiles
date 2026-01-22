{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.nixGL;
  none = types.uniq types.anything;
  mkModule = moduleName: {
    enable = mkEnableOption moduleName;
    wrapper = mkOption {
      type = none;
      default = pkg:
        if !cfg.enable
        then pkg
        else
          # Wrap the package's binaries with nixGL, while preserving the rest of
          # the outputs and derivation attributes.
          (pkg.overrideAttrs (old: {
            name = "nixGL-${pkg.name}";
            buildCommand = ''
              set -eo pipefail

              ${
                # Heavily inspired by https://stackoverflow.com/a/68523368/6259505
                pkgs.lib.concatStringsSep "\n" (map (outputName: ''
                  echo "Copying output ${outputName}"
                  set -x
                  cp -rs --no-preserve=mode "${pkg.${outputName}}" "''$${outputName}"
                  set +x
                '') (old.outputs or ["out"]))
              }

              rm -rf $out/bin/*
              shopt -s nullglob # Prevent loop from running if no files
              for file in ${pkg.out}/bin/*; do
                echo "#!${pkgs.bash}/bin/bash" > "$out/bin/$(basename $file)"
                echo "exec -a \"\$0\" ${moduleName} $file \"\$@\"" >> "$out/bin/$(basename $file)"
                chmod +x "$out/bin/$(basename $file)"
              done
              shopt -u nullglob # Revert nullglob back to its normal default state
            '';
          }));
      description = ''
        Lambda to easily wrap packages, where the wrapping is done conditionally.
      '';
    };
  };
in {
  options.nixGL = mkModule "nixGL";
  options.nixVulkan = mkModule "nixVulkan";

  config = mkIf cfg.enable {
    home.activation.installNixGL = lib.hm.dag.entryAfter ["writeBoundary"] ''
      nix profile install github:guibou/nixGL --impure
    '';
  };
}
