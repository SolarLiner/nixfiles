{ pkgs, ... }:
{
  users.nixos = {
    shell = pkgs.zsh;
  };
}
