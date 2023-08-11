self: super: {
  dpdk = super.dpdk.overrideAttrs (oldAttrs: rec {
    dpdkVersion = "23.07";
    src = fetchurl {
      url = "https://fast.dpdk.org/rel/dpdk-${dpdkVersion}.tar.xz";
      sha256 = "sha256-3gdkZfcXSg1ScUuQcuSDenJrqsgtj+fcZEytXIz3TUw=";
    };
  });
}
