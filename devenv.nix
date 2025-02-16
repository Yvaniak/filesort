{
  inputs,
  ...
}:
{
  imports = [
    inputs.devenvs.devenvModules.default
  ];
  go.enable = true;
  nix.enable = true;
}
