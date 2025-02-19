{
  description = "simple filesorter, which goal is for me to learn go.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenvs.url = "github:yvaniak/devenvs";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenvs.inputs.devenv.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          self',
          pkgs,
          lib,
          ...
        }:
        {
          packages.filesort = pkgs.buildGoModule rec {
            pname = "filesort";
            inherit ((lib.trivial.importTOML ./.cz.toml).tool.commitizen) version;

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
          packages.default = self'.packages.filesort;

          devenv.shells.default = {
            imports = [ inputs.devenvs.flakeModule ];
            go.enable = true;
            go.tests.enable = true;
            nix = {
              enable = true;
              tests.enable = true;
              flake.enable = true;
            };

          };
        };
      flake = {
      };
    };
}
