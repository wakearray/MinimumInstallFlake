{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Nvim configs handled with Nixlang/Flakes
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = {
    nixpkgs,
    disko,
    nixvim,
    ...
  }:
  {
    nixosConfigurations.hamburger = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixvim.nixosModules.nixvim
        disko.nixosModules.disko
        ./hosts/hamburger/configuration.nix
        ./modules
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
