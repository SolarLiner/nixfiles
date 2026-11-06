{pkgs, ...}: {
  environment.systemPackages = with pkgs; [just];
  nix.optimise.automatic = true;
  nix.optimise.persistent = true;
}
