{system, inputs, ...}:
{
  home.packages = [ inputs.nixvim-flake.packages.${system}.default ];
}
