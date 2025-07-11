{
  self,
  pkgs,
  ...
}: {
    # Enable 32-bit support
    hardware = {
      graphics.enable = true;
      graphics.enable32Bit = true;
    };

    # Optional: For proprietary NVIDIA users
    # services.xserver.videoDrivers = [ "nvidia" ];
    # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Enable Steam system-wide (optional — better to manage via Home Manager usually)
    programs.steam.enable = true;

    
    environment.systemPackages = with pkgs; [
      libva # Required for Steam to run properly 
      libvdpau # Required for Steam to run properly
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      gamemode
      mangohud
    ];
}

