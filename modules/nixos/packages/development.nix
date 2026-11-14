{
	flake.modules.nixos.package-development =
		{ pkgs, ... }:
		{
			environment.systemPackages = with pkgs; [
				clang
				clang-tools
				cmake
				comma
				gnumake
				libbsd
				libclang
				libgcc
				libgccjit
				lua
				pnpm
				tmux
				uv
				valgrind
			];
		};
}
