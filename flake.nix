{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    cosmic-applets.url = "github:pop-os/cosmic-applets";
    cosmic-applibrary.url = "github:pop-os/cosmic-applibrary";
    cosmic-bg.url = "github:pop-os/cosmic-bg";
    cosmic-comp.url = "github:pop-os/cosmic-comp";
    cosmic-launcher.url = "github:pop-os/cosmic-launcher";
    cosmic-osd.url = "github:pop-os/cosmic-osd";
    cosmic-panel.url = "github:pop-os/cosmic-panel";
    cosmic-session.url = "github:pop-os/cosmic-session";
    cosmic-settings.url = "github:pop-os/cosmic-settings";
    cosmic-settings-daemon.url = "github:pop-os/cosmic-settings-daemon";
    xdg-desktop-portal-cosmic.url = "github:pop-os/xdg-desktop-portal-cosmic";
  };

  outputs = {
    self,
    nixpkgs,
    cosmic-applets,
    cosmic-applibrary,
    cosmic-bg,
    cosmic-comp,
    cosmic-launcher,
    cosmic-osd,
    cosmic-panel,
    cosmic-session,
    cosmic-settings,
    cosmic-settings-daemon,
    xdg-desktop-portal-cosmic,
  }: let
    systems = [
      "x86_64-linux"
      "i686-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "armv6l-linux"
      "armv7l-linux"
    ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

    cosmic-overlay = final: prev: {
      cosmic-applets = cosmic-applets.packages.default;
      cosmic-applibrary = cosmic-applibrary.packages.default;
      cosmic-bg = cosmic-bg.packages.default;
      cosmic-comp = cosmic-comp.packages.default;
      cosmic-launcher = cosmic-launcher.packages.default;
      cosmic-osd = cosmic-osd.packages.default;
      cosmic-panel = cosmic-panel.packages.default;
      cosmic-session = cosmic-session.packages.default;
      cosmic-settings = cosmic-settings.packages.default;
      cosmic-settings-daemon = cosmic-settings-daemon.packages.default;
      xdg-desktop-portal-cosmic = xdg-desktop-portal-cosmic.packages.default;
    };
  in {
    legacyPackages = forAllSystems (system:
      import ./default.nix {
        pkgs = import nixpkgs {inherit system;};
      });
    packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});

    overlay = import ./overlay.nix ++ [cosmic-overlay];
    nixosModules = nixpkgs.lib.mapAttrs (name: value: import value) (import ./modules);
    # format the nix code in this flake
    # alejandra is a nix formatter with a beautiful output
    formatter = forAllSystems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );
  };
}
