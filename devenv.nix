{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  languages.go.enable = true;

  git-hooks.hooks = {
    gofmt.enable = true;
    golangci-lint.enable = true;
    gotest.enable = true;
    govet.enable = true;
    revive.enable = true;
    staticcheck.enable = true;

    alejandra.enable = true;
    commitizen.enable = true;
  };

  env.GREET = "filesorter in go";

  enterShell = ''
    echo hello from $GREET
  '';

  enterTest = ''
    echo "Running tests"
  '';

  outputs = {
    filesort = pkgs.buildGoModule {
      pname = "filesort";
      version = "0.1.0";

      src = ./.;

      vendorHash = null;

      meta = {
        description = "simple filesorter in go for learning";
        homepage = "https://github.com/Yvaniak/filesort";
        licence = lib.licences.gpl3Plus;
      };
    };
  };
}
