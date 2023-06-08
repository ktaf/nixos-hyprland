{ config, pkgs, inputs, lib, user, ... }:

{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05";

  systemd.user = {
    targets.sway-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  };

	nixpkgs = {
		config = {
			allowUnfree = true;
			allowUnfreePredicate = (_: true);
		};
	};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
		android-studio
		android-tools
		anydesk
		bat
		fluxcd
		flutter
		fwupd
		jq
		kind
		krew
		libdigidocpp
		libudfread
		microsoft-edge
		obsidian
		opencryptoki
		qdigidoc
		remmina
		slack
		tdesktop
		tfautomv
		trousers
		tree
		vscode
		zoom

		];


	home.sessionVariables = {
		EDITOR="code";
		BROWSER = "google-chrome-stable";
		TERMINAL = "kitty";
		# GTK_IM_MODULE = "fcitx5";
		# QT_IM_MODULE = "fcitx5";
		# XMODIFIERS = "@im=fcitx5";
		QT_QPA_PLATFORMTHEME = "gtk3";
		QT_SCALE_FACTOR = "1";
		MOZ_ENABLE_WAYLAND = "1";
		SDL_VIDEODRIVER = "wayland";
		_JAVA_AWT_WM_NONREPARENTING = "1";
		QT_QPA_PLATFORM = "wayland";
		QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
		QT_AUTO_SCREEN_SCALE_FACTOR = "1";
		WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
		WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line  
		# GBM_BACKEND = "nvidia-drm";
		CLUTTER_BACKEND = "wayland";
		__GLX_VENDOR_LIBRARY_NAME = "nvidia";
		LIBVA_DRIVER_NAME = "nvidia";
		WLR_RENDERER = "vulkan";
		__NV_PRIME_RENDER_OFFLOAD="1";

		XDG_CURRENT_DESKTOP = "Hyprland";
		XDG_SESSION_DESKTOP = "Hyprland";
		XDG_SESSION_TYPE = "wayland";
		XDG_CACHE_HOME = "\${HOME}/.cache";
		XDG_CONFIG_HOME = "\${HOME}/.config";
		XDG_BIN_HOME = "\${HOME}/.local/bin";
		XDG_DATA_HOME = "\${HOME}/.local/share";
	};

	programs.zsh = {
		enable = true;
		shellAliases = {
			ll = "ls -la";
			cat = "bat";
			switch = "sudo nixos-rebuild switch --flake .#${user}";
			switchu = "sudo nixos-rebuild switch --upgrade --flake .#${user}";
			clean = "sudo nix-collect-garbage -d";
			cleanold = "sudo nix-collect-garbage --delete-old";
			cleanboot = "sudo /run/current-system/bin/switch-to-configuration boot";
		};
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "python" "docker" ];
			theme = "dpoggi";
		};
	};

	programs.git = {
			enable = true;
			userName = "ktaf";
			userEmail = "${user}taf@gmail.com";
			extraConfig = {
				init.defaultBranch = "main";
				core.editor = "code";
				protocol.keybase.allow = "always";
				pull.rebase = "false";
				};
};

  # #Gtk 
  #   gtk = {
  #     enable = true;
  #     font.name = "TeX Gyre Adventor 10";
  #     theme = {
  #       name = "Juno";
  #       package = pkgs.juno-theme;
  #     };
  #     iconTheme = {
  #       name = "Papirus-Dark";
  #       package = pkgs.papirus-icon-theme;
  #     };

  #     gtk3.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };

  #     gtk4.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=1
  #     '';
  #   };
    
  # };




}
