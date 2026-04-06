{pkgs, ...}: let
  utils = pkgs.callPackage ../utils.nix {};
  inherit (utils) mkNormal cmd;
in {
  dependencies.lazygit.enable = true;
  plugins.lazygit.enable = true;
  keymaps = [
    (mkNormal "<leader>gg" (cmd "LazyGit") {desc = "LazyGit";})
    (mkNormal "<leader>gf" (cmd "LazyGitCurrentFile") {desc = "LazyGit (current file)";})
  ];
}
