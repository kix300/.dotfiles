{
	flake.modules.homeManager.theme =
		{ pkgs, ... }:
		let
	cursorName = "Bibata-Modern-Ice";
	cursorSize = 24;
	terminalTheme = "catppuccin-latte";
	editorTheme = "Catppuccin Latte";
		in
		{
	home.pointerCursor = {
		enable = true;
		gtk.enable = true;
		x11.enable = true;
		name = cursorName;
		package = pkgs.bibata-cursors;
		size = cursorSize;
	};

	programs.alacritty.settings.general.import = [
		"~/.config/alacritty/themes/noctalia.toml"
	];

	programs.zellij.settings = {
		theme_dark = terminalTheme;
		theme_light = terminalTheme;
	};

	programs.zed-editor.userSettings = {
		theme = {
			dark = editorTheme;
			light = editorTheme;
		};
	};
		};
}
