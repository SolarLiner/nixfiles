{
  pkgs,
  helpers,
  ...
}: let
  utils = pkgs.callPackage ../utils.nix {};
  inherit (utils) mkNormal;
  inherit (helpers.utils) mkRaw;
in {
  plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
    extensions.ui-select.enable = true;
  };
  # Dependencies
  plugins.web-devicons.enable = true;

  keymaps = [
    (mkNormal "<leader>sh" (mkRaw "require('telescope.builtin').help_tags") {desc = "[S]earch [H]elp";})
    (mkNormal "<leader>sk" (mkRaw "require('telescope.builtin').keymaps") {desc = "[S]earch [K]eymaps";})
    (mkNormal "<leader>sf" (mkRaw "require('telescope.builtin').find_files") {desc = "[S]earch [F]iles";})
    (mkNormal "<leader>ss" (mkRaw "require('telescope.builtin').builtin") {desc = "[S]earch [S]elect Telescope";})
    (mkNormal "<leader>sw" (mkRaw "require('telescope.builtin').grep_string") {desc = "[S]earch current [W]ord";})
    (mkNormal "<leader>sg" (mkRaw "require('telescope.builtin').live_grep") {desc = "[S]earch by [G]rep";})
    (mkNormal "<leader>sd" (mkRaw "require('telescope.builtin').diagnostics") {desc = "[S]earch [D]iagnostics";})
    (mkNormal "<leader>sr" (mkRaw "require('telescope.builtin').resume") {desc = "[S]earch [R]esume";})
    (mkNormal "<leader>s." (mkRaw "require('telescope.builtin').oldfiles") {desc = ''[S]earch Recent Files ("." for repeat)'';})
    (mkNormal "<leader><leader>" (mkRaw "require('telescope.builtin').buffers") {desc = "[ ] Find existing buffers";})
  ];
}
