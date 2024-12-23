{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "timl";
  home.homeDirectory = "/home/timl";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[

    # hyperland stuff

    waybar
    eww
    dunst
    libnotify
    swww
    kitty
    rofi-wayland
    blueberry
    hyprpaper
    hyprpicker
    hyprshot

    playerctl
    brightnessctl


    # hello
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.

    discord
    gimp-with-plugins
    neovim

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    #(pkgs.nerdfonts.override { fonts = [ "powerline-extra-symbols" ]; })
    #noto-fonts
    #noto-fonts-cjk
    #noto-fonts-emoji
    #liberation_ttf
    #fira-code
    #fira-code-symbols
    #mplus-outline-fonts.githubRelease
    #dina-font
    #proggyfonts
    #nerd-fonts.fira-code
    #nerd-fonts.droid-sans-mono


    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];




  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
    ".config/rofi/config.rasi".source = ./hyprland/config.rasi;
    ".config/home-manager/home.nix".source = ./home.nix;
    ".config/waybar/config".source = ./hyprland/waybar/config;
    ".config/waybar/style.css".source = ./hyprland/waybar/style.css;



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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/timl/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 10;
      background_opacity = "0.5";
      background_blur = 5;
      symbol_map = let
        mappings = [
          "U+23FB-U+23FE"
          "U+2B58"
          "U+E200-U+E2A9"
          "U+E0A0-U+E0A3"
          "U+E0B0-U+E0BF"
          "U+E0C0-U+E0C8"
          "U+E0CC-U+E0CF"
          "U+E0D0-U+E0D2"
          "U+E0D4"
          "U+E700-U+E7C5"
          "U+F000-U+F2E0"
          "U+2665"
          "U+26A1"
          "U+F400-U+F4A8"
          "U+F67C"
          "U+E000-U+E00A"
          "U+F300-U+F313"
          "U+E5FA-U+E62B"
        ];
      in
        (builtins.concatStringsSep "," mappings) + " Symbols Nerd Font";
    };
  };
  programs.bash = {
    enable = true;
    shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";#
        sysUpdate = "
              cd ~/.dotfiles
              nix flake update
              sudo nixos-rebuild switch --flake .
              home-manager switch --flake .
        ";
    };
  };
  home.shellAliases = {



  };

  fonts.fontconfig.enable = true;






  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
