{ config, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.rooting.display.plasma;
in
{

  options.rooting.display.plasma.enable = mkOption {
    type = bool;
    default = false;
  };
  config = mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    programs.xwayland.enable = true;
    environment.systemPackages = [
      pkgs.xorg.libX11
      pkgs.xorg.libxcb
      pkgs.xorg.libXi
    ];
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "de";
      variant = "";
    };
  };
}