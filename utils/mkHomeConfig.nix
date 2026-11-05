{
  user,
  modules,
  inputs,
  outputs,
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {inherit inputs outputs;};
    sharedModules = [
      inputs.nixvim.homeModules.nixvim
      ../home-manager/home.nix
    ];
    users.${user}.imports = modules;
  };
}
