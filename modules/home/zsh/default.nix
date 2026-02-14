{ options, config, lib, pkgs, ... }:
let
  cfg = config.rooting.zsh;
in
{
  options.rooting.zsh.enable = lib.mkOption {
    default = false;
    type = lib.types.bool;
  };
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      initExtra = ''
        source ~/.p10k.zsh
        bindkey '^[[A' history-substring-search-up # or '\eOA'
        bindkey '^[[B' history-substring-search-down # or '\eOB'
      '';
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch";
        clean = "sudo nix store gc";
        clean-build = "sudo nix store gc && sudo nixos-rebuild switch";
        check = "sudo nix flake check";
      };

      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "history-substring-search"];
        theme = "powerlevel10k";
      };

      plugins = [
        {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
    };
    home.file.".p10k.zsh" = {
        enable = true;
        source = ./.p10k.zsh;
    };
    home.file.".zshrc" = {
        enable = true;
        source = ./.zshrc;
        force = true;
    };
    home.sessionPath = [
      "/home/amadeus/.bun/bin:$PATH"
    ];
    home.packages = with pkgs; [
        zsh-powerlevel10k
    ];
  };
}