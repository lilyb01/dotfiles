{ self, inputs, lib, ... }:
let
  specialArgs = { inherit self inputs; };

  mkSystem = name:
    { system
    , modules ? [ ]
    , version ? "nixpkgs"
    , hmversion ? "home-manager"
    , ...
    }: inputs.${version}.lib.nixosSystem {
      inherit system specialArgs;
      modules = modules ++ [
        ./${name}/configuration.nix
        ../users
        self.nixosModules.common
        self.nixosModules.nixos
        inputs.nur.nixosModules.nur
        inputs.chaotic.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        inputs.${hmversion}.nixosModules.home-manager
        {
          networking.hostName = lib.mkDefault name;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            sharedModules = [ self.homeModules.home ];
          };
        }
      ];
    };

  mkSystemUnstable = name:
    { system
    , username ? "lily"
    , fullname ? "Lily"
    , modules ? [ ]
    , ...
    }: inputs.nixpkgs-unstable.lib.nixosSystem {
      inherit system specialArgs;
      modules = modules ++ [
        ./${name}/configuration.nix
        ../users
        self.nixosModules.common
        self.nixosModules.nixos
        inputs.disko.nixosModules.default
        inputs.home-manager-unstable.nixosModules.home-manager
        {
          networking.hostName = lib.mkDefault name;
          users.users.${username} = {
            description = fullname;
            extraGroups = [ "wheel" "networkmanager" ];
            initialPassword = "init";
            isNormalUser = true;
          };
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            sharedModules = [ self.homeModules.home ];
            users.${username} = ./${name}/home.nix;
          };
        }
      ];
    };

  mkHome = name:
    { system
    , username ? "lily"
    , hostname ? name
    , modules ? [ ]
    , ...
    }: inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = specialArgs;
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      modules = modules ++ [
        # FIXME doesn't support username-specific configs
        ./${hostname}/home.nix
        self.homeModules.common
        self.homeModules.home
        {
          home.username = username;
          home.homeDirectory = "/home/${username}";
        }
      ];
    };
in
{
  flake = {
    # NixOS configurations
    nixosConfigurations = builtins.mapAttrs mkSystem {
      cantata = { system = "x86_64-linux"; };
      #sonata = { system = "aarch64-linux"; };
      steamdeck = { system = "x86_64-linux"; };
      tapioca = { system = "x86_64-linux"; }; #version = "nixpkgs"; hmversion="home-manager";
      hopscotch = { system = "x86_64-linux";};
    };

    # Standalone home-manager configurations
    homeConfigurations = builtins.mapAttrs mkHome { };
  };
}