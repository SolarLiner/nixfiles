{pkgs, ...}: {
  imports = [../modules/dotnet.nix];
  home.packages = with pkgs; [shader-slang];
  programs.git.settings.user = {
    name = "Nathan Graule";
    email = "solarliner@gmail.com";
  };
}
