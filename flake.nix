{
  description = "fish's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
      };

    
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, zen-browser, ... }@inputs: 
    let 
      vars = {userName = "fish"; hostName = "sea"; system = "x86_64-linux";};
      
      pkgs = import nixpkgs {system = vars.system; config.allowUnfree = true;};
      lib = nixpkgs.lib;
     in {

    nixosConfigurations.${vars.hostName} = lib.nixosSystem {
      specialArgs = {
        inherit pkgs;
        inherit vars;
      };

      modules = [
        ./hosts/${vars.userName}/config.nix
      ];
    };

    homeConfigurations."${vars.userName}@${vars.hostName}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit pkgs;
        inherit inputs;
        inherit vars;
      };

      modules = [
        ./home/home.nix
      ];
    };
  };
}
