{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  #boot.kernelParams = ["rcu_nocbs=0-15" "idle=nomwait" "pci=nomsi" "processor.max_cstate=1"]; # Ryzen lockup patches
  boot.kernelParams = ["rcu_nocbs=0-15" "processor.max_cstate=5"]; # Ryzen lockup patches"

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/981b7c9a-6e90-4d2b-8693-dbed31ca8228";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B5C3-1655";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp12s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp12s0f1.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
