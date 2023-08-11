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
  in {
    legacyPackages = forAllSystems (system:
      import ./default.nix {
        pkgs = import nixpkgs {inherit system;};
      });
    packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});
    # format the nix code in this flake
    # alejandra is a nix formatter with a beautiful output
    formatter = forAllSystems (
      system:
        nixpkgs.legacyPackages.${system}.alejandra
    );
  };
}
