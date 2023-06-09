{ config, pkgs, lib, inputs, user, ... }:

{

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
     libsForQt5.plasma-wayland-protocols
     qt6.qtwayland
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
     xdg-desktop-portal-wlr
     xdg-desktop-portal
     xdg-desktop-portal-gtk
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
  };

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
programs.dconf.enable = lib.mkDefault true;

#Steam
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};


# Configure keymap in X11
services.xserver = {
  layout = "us";
  xkbVariant = "";
};

# User etc/
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
}