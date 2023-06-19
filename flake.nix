{
description = "ktaf-nixos";

inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  hyprland.url = "github:hyprwm/Hyprland";
  home-manager.url = "github:nix-community/home-manager/release-23.05";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";   };


outputs = { self, nixpkgs, hyprland, home-manager, ... }: 
  let
    user = "kourosh";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
  in {
      nixosConfigurations = {
        ${user} = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {inherit user;};
            modules = [ ./configuration.nix 
            hyprland.nixosModules.default
            {
            programs.hyprland = {
              enable = true;
              nvidiaPatches = true;
              xwayland = {
                enable = lib.mkDefault true;
                hidpi = true;
              };
            };
            }
            home-manager.nixosModules.home-manager
            {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit user;};
            home-manager.users.${user} = import ./modules/home.nix;
            }
];
          };
        };
    };
}

#nixos-23.05