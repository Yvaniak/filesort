{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
      };
    in
    {

      packages.x86_64-linux.hello = pkgs.buildGoModule rec {
        pname = "filesort";
        version = "1.0.0";

        src = ./.;

        vendorHash = null;

        ldflags = [
          "-s"
          "-w"
        ];

        meta = {
          description = "Simple filesorter in go for learning";
          homepage = "https://github.com/Yvaniak/filesort";
          changelog = "https://github.com/Yvaniak/filesort/blob/${src.rev}/CHANGELOG.md";
          license = pkgs.lib.licenses.gpl3Only;
          mainProgram = "filesort";
        };
      };

      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    };
}
