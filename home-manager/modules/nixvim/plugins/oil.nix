{pkgs, ...}: let
  utils = pkgs.callPackage ../utils.nix {};
  inherit (utils) mkNormal;
in {
  plugins.oil.enable = true;
  plugins.oil-git-status.enable = true;

  keymaps = [
    (mkNormal "<leader>-" "<cmd>Oil<CR>" {desc = "[-] Open file browser (oil) / Move up";})
  ];
}
