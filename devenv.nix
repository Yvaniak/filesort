{
  pkgs,
  ...
}:
{
  languages.go.enable = true;
  languages.nix.enable = true;

  git-hooks.hooks = {
    gofmt.enable = true;
    golangci-lint.enable = true;
    gotest.enable = true;
    govet.enable = true;
    revive.enable = true;
    staticcheck.enable = true;
    govulncheck = {
      enable = true;
      name = "govulncheck";
      entry = "go run golang.org/x/vuln/cmd/govulncheck@latest ./...";
      files = "\\.go$";
      pass_filenames = false;
    };

    nixfmt-rfc-style.enable = true;
    statix.enable = true;
    deadnix.enable = true;
    commitizen.enable = true;
  };

  enterShell = ''
    echo hello from filesorter in go
  '';

  packages = [ pkgs.nil ];
}
