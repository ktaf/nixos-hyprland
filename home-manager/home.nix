{ config, pkgs, inputs, lib, ... }:

{
  home.username = "kourosh";
  home.homeDirectory = "/home/kourosh";
  home.stateVersion = "23.05";

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
		electron_23
		etcher
		fluxcd
		flutter
		fwupd
		jdk
		jq
		jre8
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
	};

	programs.zsh = {
		enable = true;
		shellAliases = {
			ll = "ls -la";
			cat = "bat";
			switch = "sudo nixos-rebuild switch --flake .#kourosh";
			switchu = "sudo nixos-rebuild switch --upgrade --flake .#kourosh";
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
			userEmail = "kouroshtaf@gmail.com";
			extraConfig = {
				init.defaultBranch = "main";
				core.editor = "nano";
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
