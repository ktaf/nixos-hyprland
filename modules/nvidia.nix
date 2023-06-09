{ config, pkgs, lib, inputs, ... }:
{

services.xserver = {
  videoDrivers = [ "nvidia" ];

  config = ''
    Section "Device"
        Identifier  "Intel Graphics"
        Driver      "intel"
        #Option      "AccelMethod"  "sna" # default
        #Option      "AccelMethod"  "uxa" # fallback
        Option      "TearFree"        "true"
        Option      "SwapbuffersWait" "true"
        BusID       "PCI:0:2:0"
        #Option      "DRI" "2"             # DRI3 is now default
    EndSection

    Section "Device"
        Identifier "nvidia"
        Driver "nvidia"
        BusID "PCI:1:0:0"
        Option "AllowEmptyInitialConfiguration"
    EndSection
  '';
  screenSection = ''
    Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
  '';
};

hardware.opengl.enable = lib.mkDefault true;
hardware.nvidia.nvidiaSettings = true;
hardware.nvidia.powerManagement.enable = true;
# Optionally, you may need to select the appropriate driver version for your specific GPU.
hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
# nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
hardware.nvidia.modesetting.enable = true;

#Cuda
services.xmr-stak.cudaSupport = true;

}