{lib, ...}: {
  dependencies.roslyn_ls.enable = lib.mkForce false;
  plugins.roslyn.enable = true;
}
