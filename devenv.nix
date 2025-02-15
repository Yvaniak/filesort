{
  inputs,
  ...
}:
{
  imports = [
    inputs.devenvs.homeManagerModules.devenvs.default
  ];
  go.enable = true;
  nix.enable = true;
}
