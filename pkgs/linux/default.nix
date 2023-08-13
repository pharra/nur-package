# Minimal Linux kernel configuration for a kernel with the following properties:
# - x86_64
# - relocatable
# - initrd loading
# - elf and shebang executables
# - printk
# - serial and tty
# - hypervisor detection support
# - dynamic module loading
# - shutdown/poweroff
#
# The kernel config itself probably builds with a big variety of Linux kernel
# configurations. All important drivers are built-in ("=Y"). There are no modules
# build.
{
  lib,
  # the selected Linux kernel from "pkgs.linux_*"
  selectedLinuxKernelPkg,
  pkgs,
  buildLinux,
} @ args:
buildLinux (args
  // rec {
    version = "${selectedLinuxKernelPkg.version}";
    src = selectedLinuxKernelPkg.src;
    kernelPatches = [./mlx4.patch];

    extraConfig = ''
    '';
  }
  // (args.argsOverride or {}))
