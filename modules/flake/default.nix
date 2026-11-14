{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    ./hosts
  ];
}
