{ config, lib, pkgs, ... }:

with lib;
with lib.types;
let
  cfg = config.rooting.packages.utils.core;
in
{
  options.rooting.packages.utils.core.enable = mkOption {
    default = false;
    type = bool;
  };

  #Extended utils
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;[
      git
      wget
      tree
      unzip
      killall
      btop
      dig
      traceroute
      lnav
      pciutils
      cifs-utils
      xsel
      tmux
      zsh
      restic
      rclone
      cachix
    ];

    users.defaultUserShell = pkgs.zsh;
    #services.solaar = {
    #			enable = true;
    #			window = "hide";
    #			extraArgs = "--restart-on-wake-up";
    #		};
  };
}