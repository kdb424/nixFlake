{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = ["amdgpu"];
  boot.extraModulePackages = with config.boot.kernelPackages; [zenpower];

  # amdgpu opencl
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
    amdvlk
  ];

  # For 32 bit applications
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  environment.systemPackages = with pkgs; [radeontop zenmonitor];
}
