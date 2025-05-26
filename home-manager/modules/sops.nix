{ config, ... }: let inherit (config) home; in {
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
