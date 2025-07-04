{
  description = "CHANGEME";

  inputs = {
    gepetto.url = "github:gepetto/nix";
    flake-parts.follows = "gepetto/flake-parts";
    nixpkgs.follows = "gepetto/nixpkgs";
    nix-ros-overlay.follows = "gepetto/nix-ros-overlay";
    systems.follows = "gepetto/systems";
    treefmt-nix.follows = "gepetto/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ inputs.gepetto.flakeModule ];
      perSystem =
        {
          lib,
          pkgs,
          self',
          ...
        }:
        {
          packages = {
            default = self'.packages.CHANGEME;
            CHANGEME = pkgs.CHANGEME.overrideAttrs {
              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./CHANGEME
                ];
              };
            };
          };
        };
    };
}
