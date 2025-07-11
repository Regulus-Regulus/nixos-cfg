{
  self,
  pkgs,
  ...
}: {
    # Enable 32-bit support
    hardware.opengl.enable = true;
    hardware.opengl.driSupport32Bit = true;

    # Optional: For proprietary NVIDIA users
    # services.xserver.videoDrivers = [ "nvidia" ];
    # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Enable Steam system-wide (optional — better to manage via Home Manager usually)
    programs.steam.enable = true;

    # Required for Steam to run properly
    environment.systemPackages = with pkgs; [
      libva
      libvdpau
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      gamemode
      mangohud
    ];
}

