{
  pkgs,
  lib,
  ...
}:
pkgs.buildGoModule rec {
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
}
