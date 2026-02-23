{
	pkgs,
	inputs,
	...
}:
{
	nixpkgs.config.allowUnfree = true;
	users.extraGroups.vboxusers.members = [ "ozen wheel" ];
	users.users.ozen = {
		isNormalUser = true;
		description = "Killian";
		extraGroups = [
			"networkmanager"
			"wheel"
			"adbusers"
			"lp"
			"i2c"
			"docker"
			"video"
			"audio"
			"jackaudio"
		];
		packages = with pkgs; [
			aapt
			adbtuifm
			adwaita-icon-theme
			aircrack-ng
			android-tools
			apktool
			appimage-run
			ardour
			lsp-plugins
			gxplugins-lv2
			tamgamp-lv2
			neural-amp-modeler-lv2
			asusctl
			bear
			btop-cuda
			brightnessctl
			clang-tools
			comma
			cmake
			ddcui
			ddcutil
			direnv
			discord
			distrobox
			fd
			glfw
			godot
			guitarix
			gpu-screen-recorder
			hyprlock
			jack2
			kdePackages.qtsvg
			kdePackages.qtwayland
			kdePackages.qtdeclarative
			kitty
			lua
			lutris
			bottles
			lshw
			# n8n
			nil
			nodejs
			norminette
			ntfs3g
			obs-studio
			openjdk
			pavucontrol
			prismlauncher
			pulseaudio
			python3
			qjackctl
			r2modman
			revolt-desktop
			rofi-power-menu
			rofi
			signal-desktop
			spotify
			supabase-cli
			swaylock-fancy
			swww
			telegram-desktop
			util-linux
			uv
			vimPlugins.nvim-treesitter-parsers.qmljs
			wayvnc
			wine
			wofi
			thunar
			inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
			# inputs.quickshell.packages."${stdenv.hostPlatform.system}".default
		];
	};
}
