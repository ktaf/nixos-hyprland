{ config, pkgs, lib, inputs, ... }:
{
  # Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix 
    ./vm.nix];

  #fonts
    fonts.fonts = with pkgs; [
      font-awesome
     (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
     ];
  #emojis
    services.gollum.emoji = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Define your hostname
  networking.hostName = "nixos";
  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;  

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Tallinn";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Gnome login
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  #services.xserver.displayManager.gdm.settings = {
  #};
  
  #services.xserver.displayManager.defaultSession = "hyprland";
  
  
  #sddm
  #services.xserver.displayManager.sddm.enable = true;

  #Flatpak
  services.flatpak.enable = true;
  #locate
  services.locate.enable = true;

  # Enable Xwayland
  programs.xwayland.enable = true;             #enabled in flake
  programs.hyprland.enable = true;             #enabled in flake.nix
  programs.hyprland.nvidiaPatches = true;      #enabled in flake.nix

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    #isDefault
    #wireplumber.enable= true;
  
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  
  #xdg
  
#  xdg.portal = {
#  enable = true;
#  extraPortals = with pkgs; [
#    xdg-desktop-portal-wlr
#  ];
#  };

#    wlr = {
#    enable = true;
#      };
#    };

  environment.etc."xdg/user-dirs.defaults".text= ''
    DESKTOP=System/Desktop
    DOWNLOAD=System/Downloads
    TEMPLATES=System/Templates
    PUBLICSHARE=System/Public
    DOCUMENTS=System/Documents
    MUSIC=Media/music
    PICTURES=Media/photos
    VIDEOS=Media/video 
    '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Kourosh";
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" "kvm" ];
    packages = with pkgs; [
     swaylock-effects swayidle wlogout swaybg  #Login etc..  
     waybar                                    #topbar 
     wayland-protocols
     libsForQt5.qt5.qtwayland
     kanshi                                    #laptop dncies
     rofi mako rofimoji                        #Drawer + notifications
     jellyfin-ffmpeg                           #multimedia libs
     viewnior                                  #image viewr
     pavucontrol                               #Volume control
     xfce.thunar                               #filemanager
     gnome-text-editor
     gnome.file-roller
     gnome.gnome-font-viewer
     gnome.gnome-calculator
     vlc                                       #Video player
     amberol                                   #Music player
     cava                                      #Sound Visualized
     wl-clipboard                              
     wf-recorder                               #Video recorder
     sway-contrib.grimshot                     #Screenshot
     ffmpegthumbnailer                         #thumbnailer
     playerctl                                 #play,pause..
     pamixer                                   #mixer
     brightnessctl                             #Brightness control
     wlr-randr
     wayland
     wayland-scanner
     wayland-utils
     egl-wayland
     pkgs.xorg.xeyes
     glfw-wayland
     pkgs.qt6.qtwayland
     wev    
     alsa-lib
     alsa-utils
     flac
     pulsemixer
     linux-firmware
     sshpass
     rustc
     imagemagick
     flameshot
     bluez
     blueman
     gnome.file-roller
     grim
     htop
     intel-media-driver
     jetbrains-mono
     libva
     libsForQt5.qt5ct
     libsForQt5.sddm
     linuxHeaders
     lxappearance
     networkmanagerapplet
     noto-fonts-emoji
     nvidia-vaapi-driver
     libva-utils
     glxinfo
     polkit_gnome
     slurp
     swappy
     swaycons
     swww
     wofi
     xfce.xfce4-settings
     xdg-desktop-portal-hyprland
     electron
     ####GTK Customization####
     nordic
     papirus-icon-theme
     gtk3
     glib
     xcur2png
     rubyPackages.glib2
     libcanberra-gtk3                          #notification sound
     #########System#########
     kitty
     zsh
     google-chrome
     firefox
     gnome.gnome-system-monitor
     libnotify
     poweralertd
     dbus
     #gsettings-desktop-schemas
     #wrapGAppsHook
     #xdg-desktop-portal-hyprland
     ####photoshop dencies####
     gnome.zenity
     wine64Packages.waylandFull
     curl
     #########################
    ];
    # SHELL ZSH
    shell = pkgs.zsh;
  };


# Enable ZSH
programs.zsh.enable = true;

#starship
programs.starship.enable = true;

#thunar dencies
programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
  thunar-dropbox-plugin
  thunar-media-tags-plugin
];
services.gvfs.enable = true; 
services.tumbler.enable = true;

#gnome outside gnome
programs.dconf.enable = true;

#Steam
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};

 # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

#swaylock pass verify
  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
    wlr.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
 # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     vim
     wget
     git
     gh
  ];


###############################################  Still experimental  ###############################################

#systemd = {
#  user.services.polkit-gnome-authentication-agent-1 = {
#    description = "polkit-gnome-authentication-agent-1";
#    wantedBy = [ "graphical-session.target" ];
#    wants = [ "graphical-session.target" ];
#    after = [ "graphical-session.target" ];
#    serviceConfig = {
#        Type = "simple";
#        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
#        Restart = "on-failure";
#        RestartSec = 1;
#        TimeoutStopSec = 10;
#      };
#  };
#};


#pci-passthroughnix

#      pciPassthrough = {
#    enable = true;
#    pciIDs = "10de:1ba1,10de:10f0";
#    cpuType = "intel";
#    libvirtUsers = [ "sager" ];[
#  };


#VFIOnix

#    specialisation."VFIO".configuration = {
#  system.nixos.tags = [ "with-vfio" ];
#  vfio.enable = true;
#};


#t.initrd.kernelModules = 
#  "vfio_pci"
#  "vfio"
#  "vfio_iommu_type1"
#  "vfio_virqfd"

#  "nvidia"
#  "nvidia_modeset"
#  "nvidia_uvm"
#  "nvidia_drm"
#];


  #Nix Virtualisation
  #virtualisation.spiceUSBRedirection.enable = true;
  #virtualisation.libvirtd.enable = true;
  #virtualisation.libvirtd.qemu.ovmf.enable = true;
  #virtualisation.libvirtd.qemu.swtpm.enable = true;
  #environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];

###############################################  Still experimental  ###############################################

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable the Bluethooth daemon.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

#Nvidia
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

  hardware.opengl.enable = true;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.powerManagement.enable = true;

  #Cuda
  services.xmr-stak.cudaSupport = true;
  
  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  
  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

#tlp
services.tlp.enable = true;

#upower dbus
services.upower.enable = true;
powerManagement = {
  enable = true;
  cpuFreqGovernor = "ondemand";
};

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
    #For Chromecast from chrome
#    networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 60999; } ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?


  #Overlays

  #Waybar wlr/Workspaces
    nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}


