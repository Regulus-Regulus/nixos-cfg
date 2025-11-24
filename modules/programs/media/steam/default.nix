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
  programs.steam.remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  programs.steam.dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  programs.steam.localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  environment.systemPackages = with pkgs; [
    libva # Required for Steam to run properly
    libvdpau # Required for Steam to run properly
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    mesa
    gamemode
    mangohud
  ];
}
