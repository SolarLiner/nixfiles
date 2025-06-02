{ config, inputs, ... }: let inherit (config) home; in {
  imports = [inputs.sops-nix.homeManagerModules.sops];
  sops = {
    age.keyFile = "${home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/sops.yaml;
    secrets.MISTRAL_API_KEY = {};
    secrets.ANTHROPIC_API_KEY = {};
  };
  home.sessionVariables = {
    MISTRAL_API_KEY = "$(cat ${config.sops.secrets.MISTRAL_API_KEY.path})";
    ANTHROPIC_API_KEY = "$(cat ${config.sops.secrets.ANTHROPIC_API_KEY.path})";
  };
}
