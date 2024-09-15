{
  description = "NixOS Config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    hardware.url = "github:nixos/nixos-hardware";

    # Nixpkgs
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
    home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

    # disko - dunno if i'll use this but just in case
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # unneeded until i work on this again...
    #agenix.url = "github:ryantm/agenix";
    #agenix.inputs.nixpkgs.follows = "nixpkgs";
    #sops-nix.url = "github:Mic92/sops-nix";

    #nix-secrets = {
    #  url = "git+ssh://git@github.com/lilyb01/nix-secrets?shallow=1&ref=main";
    #  flake = false;
    #};

    # Hyprland and plugins
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    #Hyprspace = {
    #  url = "github:ReshetnikovPavel/Hyprspace";

    #  # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
    #  inputs.hyprland.follows = "hyprland";
    #};

    # xdg autostart module
    xdg-autostart.url = "github:Zocker1999NET/home-manager-xdg-autostart";

    # declarative flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    jovian.follows = "chaotic/jovian";

    nur.url = "github:nix-community/NUR";

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs = inputs@ { flake-parts, ... }:

    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux"];

      imports = [
        ./hosts/flake-module.nix
        ./modules/flake-module.nix
        ./lib/flake-module.nix
      ];
    };

}
