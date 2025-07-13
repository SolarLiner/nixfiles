{ config, lib, ... }: with lib; {
  options.home.isGraphical = mkEnableOption "isGraphical";
}
