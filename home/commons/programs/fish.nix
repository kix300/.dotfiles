{ _ , ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
				set fish_greeting # Disable greeting
				alias nswitch="rm ~/.gtkrc-2.0 && nh os switch"
				alias dofus="appimage-run ~/Games/DOFUS/Ankama\ Launcher-Setup-x86_64.AppImage"
				alias zed="zeditor ."
				alias niri-test="~/Projects/Rust/niri/result/bin/niri"

				alias g="git"
				alias ga="git add"
				alias gc="git commit"
				alias gl="git pull"
				alias gs="git switch"
				alias gp="git push"

				function nvimfiles
				nvim ~/.dotfiles
				end

				bind alt-] nvimfiles
				direnv hook fish | source 
		'';
	};
}
