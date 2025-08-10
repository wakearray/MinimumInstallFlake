{ ... }:
{
  imports =
  [
    ./hardware-configuration.nix
    # ./disko-config.nix
    ../../modules
  ];

  config = {
    # Bootloader.
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = [
        "/dev/disk/by-partlabel/NIXBOOT"
      ];
    };

    # Enable networking.
    networking = {
      networkmanager.enable = true;
      hostName = "Hamburger"; # Define your hostname
      firewall = {
        enable = true;
        allowPing = true;
      };
    };

    users.users.kent = {
      isNormalUser = true;
      description = "Kent";
      extraGroups = [ "networkmanager" "wheel" ];
      initialHashedPassword = "$y$j9T$a09xjLjAlf/rHpCdhnAM4/$wlp6tDHeX2OfnUTXA29RWbALS5PvLc/1cpu0rZF4170";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBLzZraL3GJk+1Az59CEWslGqu8OlZPTyGxOrq6m9/p7"
      ];
    };

    nix.settings.trusted-users = [ "kent" ];

    services.openssh.enable = true;

    system.stateVersion = "25.11";
  };
}
