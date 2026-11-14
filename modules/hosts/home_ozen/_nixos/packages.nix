{ pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;

	users.extraGroups.vboxusers.members = [ "ozen" "wheel" ];

	users.users.ozen.packages = with pkgs; [
		aapt
		adbtuifm
		adwaita-icon-theme
		aircrack-ng
		android-tools
		ansible
		apktool
		appimage-run
		ardour
		awww
		bear
		calf
		cemu
		dolphin-emu
		distrobox
		fd
		glfw
		godot
		gpu-screen-recorder
		gxplugins-lv2
		kdePackages.qtdeclarative
		kdePackages.qtsvg
		kdePackages.qtwayland
		lsp-plugins
		lshw
		mpv
		neural-amp-modeler-lv2
		nil
		nodejs
		norminette
		ntfs3g
		openjdk
		opentofu
		prismlauncher
		python3
		qjackctl
		r2modman
		revolt-desktop
		signal-desktop
		supabase-cli
		swaylock-fancy
		tamgamp-lv2
		telegram-desktop
		vimPlugins.nvim-treesitter-parsers.qmljs
		wine
		wofi
	];
}
