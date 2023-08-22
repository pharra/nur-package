{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "x86_64-linux"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    legacyPackages = forAllSystems (system:
      import ./default.nix {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      });
  in {
    inherit legacyPackages;
    packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});
    overlay = builtins.attrValues (forAllSystems (system: self.legacyPackages.${system}.overlays));

    overlays.default = import ./overlay.nix;
    
    nixosModules = import ./modules;
    # format the nix code in this flake
    # alejandra is a nix formatter with a beautiful output
    formatter = forAllSystems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );
  };
}
