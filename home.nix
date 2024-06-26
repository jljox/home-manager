{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jljox";
  home.homeDirectory = "/Users/jljox";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgs.bash
    pkgs.iterm2
    pkgs.direnv
    pkgs.awscli2
    pkgs.nerdfonts
    pkgs.elmPackages.elm
    pkgs.cabal-install
    pkgs.ghc
    pkgs.hscolour
    pkgs.lambdabot
    pkgs.haskellPackages.pretty-show
    pkgs.haskellPackages.hoogle
    pkgs.haskellPackages.hlint

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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

    # ".zshrc".source = ./dotfiles/zshrc;
    ".ghci".source = ./dotfiles/ghci;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jljox/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vi";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.script-directory = {
    enable = true;
    settings = {
      SD_ROOT = "${config.home.homeDirectory}/.config/home-manager/script-directory";
      SD_EDITOR = "nvim";
      SD_CAT = "cat";
    };
  };

  programs.hstr = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = false;
    shellAliases = {
      cls = "clear";
    };
    initExtra = ''
      eval "$(hstr --show-zsh-configuration)"
      bindkey -s "^R" "^[0ihstr -- ^J"
    '';
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      cls = "clear";
      hh = "hstr";
    };     
    initExtra = ''
      set -o vi
      export HSTR_CONFIG=hicolor
      shopt -s histappend
      export HISTCONTROL=ignorespace
      export HISTFILESIZE=10000
      export HISTSIZE=$\{HISTFILESIZE\}
      export PROMPT_COMMAND="history -a; history -n;"
      if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\e^ihstr -- \n"'; fi
      if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\e^ihstr -k \n"'; fi
      export HSTR_TIOCSTI=y
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      shlvl = {
        disabled = false;
        symbol = "L ";
      };
      haskell.symbol = "λ ";
    };
  };

  programs.jq.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withPython3 = false;
  };

  programs.git = {
    enable = true;
  };

  programs.eza = {
    enable = true;
    icons = true;
    enableAliases = true;
  };

}
