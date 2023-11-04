{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.kernelParams = [ "rcu_nocbs=0-14 processor.max_cstate=1" ]; # Lockup workaround

  # TODO Put correct filesystems here
  # fileSystems."/" = {
  #   device = "/dev/disk/by-uuid/e31230ab-566c-478f-a078-d2db637696b6";
  #   fsType = "ext4";
  # };

  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-uuid/042D-AF32";
  #   fsType = "vfat";
  # };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
      randomEncryption.enable = true;
    }
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 40;
    priority = 10;
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
