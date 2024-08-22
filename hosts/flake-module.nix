{ self, inputs, lib, ... }:
let
  specialArgs = { inherit self inputs; };

  mkSystem = name:
    { system
    , username ? "lily"
    , fullname ? "Lily"
    , modules ? [ ]
    , ...
    }: inputs.nixpkgs.lib.nixosSystem {
      inherit system specialArgs;
      modules = modules ++ [
        ./${name}/configuration.nix
        self.nixosModules.common
        self.nixosModules.nixos
        inputs.disko.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
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
      hopscotch = { system = "x86_64-linux"; };
      #sonata = { system = "aarch64-linux"; };
      #steamdeck = { system = "x86_64-linux"; };
    };

    # Standalone home-manager configurations
    homeConfigurations = builtins.mapAttrs mkHome { };
  };
}