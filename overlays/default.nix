{
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
  ...
}: {
  # Add your overlays here
  #
  # my-overlay = import ./my-overlay;
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
  dpdk-overlay = import ./dpdk;
}
