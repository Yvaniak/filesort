{
  inputs,
  ...
}:
{
  imports = [
    inputs.devenvs.homeManagerModules.default
  ];
  go.enable = true;
  nix.enable = true;
}
