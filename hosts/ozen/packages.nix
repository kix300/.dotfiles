{
	pkgs,
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
			awww

			#guitar 
			ardour
			lsp-plugins
			gxplugins-lv2
			calf
			tamgamp-lv2
			neural-amp-modeler-lv2
			bear
			ddcui
			ddcutil
			distrobox
			fd
			gh
			glfw
			godot
			gpu-screen-recorder
			jack2
			kdePackages.qtsvg
			kdePackages.qtwayland
			kdePackages.qtdeclarative
			lshw
			# n8n
			mpv
			nil
			nodejs
			norminette
			ntfs3g
			openjdk
			prismlauncher
			python3
			qjackctl
			r2modman
			revolt-desktop
			signal-desktop
			stoat-desktop
			supabase-cli
			swaylock-fancy
			telegram-desktop
			util-linux
			vimPlugins.nvim-treesitter-parsers.qmljs
			wine
			wofi
		];
	};
}
