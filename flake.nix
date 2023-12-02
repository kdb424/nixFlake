{
  description = "Your new nix config";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-index-database,
    stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    mkNixos = modules:
      nixpkgs.lib.nixosSystem {
        modules =
          modules
          ++ [
            home-manager.nixosModules.home-manager
            nix-index-database.nixosModules.nix-index
            stylix.nixosModules.stylix
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {inherit inputs outputs;};
            }
          ];
        specialArgs = {inherit inputs outputs;};
      };

    mkDarwin = system: modules:
      inputs.darwin.lib.darwinSystem {
        inherit modules system inputs;
        specialArgs = {inherit inputs outputs;};
      };

    mkHome = modules: pkgs:
      home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
      };
  in rec {
    checks = forAllSystems (system: {
      pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
        };
      };
    });
    # Your custom packages
    # Acessible through 'nix build', 'nix shell', etc
    #packages = forAllSystems (system:
    #  let pkgs = nixpkgs.legacyPackages.${system};
    #  in import ./pkgs { inherit pkgs; }
    #);
    # Devshell for bootstrapping
    # Acessible through 'nix develop' or 'nix-shell' (legacy)
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    # nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    # homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # M1 mac mini
      farnsworth = mkNixos [./hosts/farnsworth];

      # Laptop
      amy = mkNixos [
        ./hosts/amy
        {home-manager.users.kdb424 = ./home-manager/machines/amy.nix;}
      ];

      # Small intel server
      kif = mkNixos [
        ./hosts/kif
        {home-manager.users.kdb424 = ./home-manager/machines/headless.nix;}
      ];

      # Ryzen Fifth gen
      planex = mkNixos [
        ./hosts/planex
        {home-manager.users.kdb424 = ./home-manager/machines/planex.nix;}
      ];

      # Ryzen Second gen
      morbo = mkNixos [
        ./hosts/morbo
        {home-manager.users.kdb424 = ./home-manager/machines/headless.nix;}
      ];
    };

    darwinConfigurations = {
      # M2 Mac mini
      cubert = mkDarwin "aarch64-darwin" [
        ./hosts/cubert
        home-manager.darwinModules.home-manager
      ];
    };

    homeConfigurations = {
      "kdb424@cubert" = mkHome [./home-manager/machines/cubert.nix] nixpkgs.legacyPackages.aarch64-darwin;
      "kdb424@farnsworth" = mkHome [./home-manager/machines/headless.nix] nixpkgs.legacyPackages.aarch64-linux;
      "kdb424@zapp" =
        mkHome [
          stylix.homeManagerModules.stylix
          ./home-manager/machines/headless.nix
        ]
        nixpkgs.legacyPackages.x86_64-linux;
    };
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      # Don't follow nixpkgs or cache will miss
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
