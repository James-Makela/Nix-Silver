{ config, pkgs, lib, inputs, ... }:

{
  imports = [ ./programs ];

  home.username = "user";
  home.homeDirectory = "/home/user";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = { 
    EDITOR = "nvim";
    MANPAGER="nvim +Man!";
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      l = "eza -lh --group-directories-first --icons=auto";
      ll = "eza -lha --group-directories-first --icons=auto";
      update = "nh os switch ~/.dotfiles/nixos/ -H default -- --option cores 3 --option max-jobs 3";
      nixconfig = "nvim ~/.dotfiles/nixos/hosts/default/configuration.nix";
      homeconfig = "nvim ~/.dotfiles/nixos/hosts/default/home.nix";
      ff =
        "nvim +'Telescope find_files hidden=false layout_config={height=0.9}'";
      gg =
        "nvim +'Telescope live_grep hidden=false layout_config={height=0.9}'";
      repos = "cd ~/source/repos/";
      laragon =
        "cd ~/source/repos/saas-fed/laradock && sudo docker-compose up -d nginx mariadb phpmyadmin workspace redis mailpit";
      laragon-stop =
        "cd ~/source/repos/saas-fed/laradock && sudo docker-compose stop";
      budget = "cd ~/source/repos/laravel/budget/";
      clay = "cd ~/source/repos/laravel/Clay/";
      ufacarb = "cd ~/.dotfiles/nixos/ && nix flake update && ga . && gc -m 'Update flake' && gp && update";
    };
    history.size = 1000;

    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      fortune
    '';

    zplug = {
      enable = true;
      plugins = [{
        name = "romkatv/powerlevel10k";
        tags = [ "as:theme" "depth:1" ];
      }];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "direnv" ];
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Name";
        email = "email@example.com";
      };
      init.defaultBranch = "main";
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
}
