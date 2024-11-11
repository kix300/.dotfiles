{ pkgs ? import <nixpkgs> {} }:
	pkgs.mkShellNoCC {
		nativeBuildInputs = with pkgs.buildPackages; [ 
			clang
			readline
		];
		shellHook = ''fish'';
}
