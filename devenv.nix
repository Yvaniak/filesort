{
  inputs,
  ...
}:
{
  imports = [
    inputs.devenvs.devenvModules.default
  ];
  go.enable = true;
  go.tests.enable = true;
  nix = {
    enable = true;
    tests.enable = true;
    flake.enable = true;
  };
}
