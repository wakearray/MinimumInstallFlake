{ pkgs, lib, ... }:{
  imports = [
    ./nixvim.nix
    ./ssh.nix
    ./zsh.nix
  ];

  config = {
    environment.systemPackages = with pkgs; [
      # 7-Zip
      _7zz

      # eza - Modern, maintained replacement for ls
      # https://github.com/eza-community/eza
      eza

      # Zoxide - A fast cd command that learns your habits
      # https://github.com/ajeetdsouza/zoxide
      # https://www.youtube.com/watch?v=aghxkpyRVDY
      zoxide

      # fzf - Command-line fuzzy finder written in Go
      # https://github.com/junegunn/fzf
      fzf

      # Lemonade - Remote utility tool that to copy, paste and open browsers over TCP
      # https://github.com/lemonade-command/lemonade/
      lemonade

      # https://www.gnu.org/software/wget/
      wget

      # Terminal UI for Systemd Logs and Status
      # https://crates.io/crates/systemctl-tui
      systemctl-tui

      # hyfetch - neofetch with pride flags
      # https://github.com/hykilpikonna/HyFetch
      hyfetch

      # GitUI provides you with the comfort of a git GUI
      # right in your terminal
      # https://github.com/extrawurst/gitui
      gitui

      # gum - A tool for glamorous shell scripts
      # https://github.com/charmbracelet/gum
      gum
    ];

    # Enable userborn declarative user management
    services.userborn.enable = true;

    nixpkgs.config.allowUnfree = true;

    nix = {
      package = pkgs.lixPackageSets.latest.lix;
      settings = {
        # Enable flakes.
        experimental-features = [ "nix-command" "flakes" ];

        # download-buffer-size is unavailable in lix
        # download-buffer-size = 524288000; # 500 MiB

        # Uses hard links to remove duplicates in the nix store
        auto-optimise-store = true;
      };
    };

    programs = {
      # Installs git as a system program
      git.enable = true;
      # Not Another Command Line Nix Helper
      nh.enable = true;
    };

    # Set your time zone.
    time.timeZone = lib.mkDefault "America/New_York";

    # Select internationalisation properties.
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };
  };
}
