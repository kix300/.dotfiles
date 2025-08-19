{ config, lib, ... }:

let
	homeDir = config.home.homeDirectory;
	quickshellDir = "${homeDir}/.dotfiles/quickshell/qml";
	quickshellTarget = "${homeDir}/.config/quickshell";
	# faceIconSource = "${homeDir}/nixos/assets/profile.gif";
	# faceIconTarget = "${homeDir}/.face.icon";
	# ln -sfn "${faceIconSource}" "${faceIconTarget}"

in {
	home.activation.symlinkQuickshellAndFaceIcon = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
	ln -sfn "${quickshellDir}" "${quickshellTarget}"
	'';
}
