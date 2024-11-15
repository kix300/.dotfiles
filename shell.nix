{ pkgs ? import <nixpkgs> {} }:
	pkgs.mkShell {
		nativeBuildInputs = with pkgs.buildPackages; [
			clang
			readline
		];
		shellHook = ''fish'';
}
