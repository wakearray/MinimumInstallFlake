{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nvim configs handled with Nixlang/Flakes
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Automated deployment scripts
    nixinate.url = "github:matthewcroughan/nixinate";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    nixvim,
    nixinate,
    ...
  }:
  {
    apps = nixinate.nixinate.x86_64-linux self;
    nixosConfigurations.Hamburger = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixvim.nixosModules.nixvim
        #disko.nixosModules.disko
        ./hosts/hamburger/configuration.nix
        ./modules
        {
          _module.args.nixinate = {
            host = "5.161.77.151";
            sshUser = "nixos";
            buildOn = "local"; # valid args are "local" or "remote"
            substituteOnTarget = true; # if buildOn is "local" then it will substitute on the target, "-s"
            hermetic = true;
          };
        }
      ];
    };
    # Use this for all other targets
    # nixos-anywhere --flake .#generic --generate-hardware-config nixos-generate-config ./hardware-configuration.nix <hostname>
    nixosConfigurations.generic = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixvim.nixosModules.nixvim
        disko.nixosModules.disko
        ./configuration.nix
        ./hardware-configuration.nix
        ./modules
      ];
    };
  };
}
