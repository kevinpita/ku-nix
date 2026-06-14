{ lib
, buildGoModule
, fetchFromGitHub
,
}:

buildGoModule (finalAttrs: {
  pname = "kli";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "bjarneo";
    repo = "kli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-uTw0C2pa5kxoWVOfAnFLtNGHRAua/zhUjXuyPHjQyvU=";
  };

  vendorHash = "sha256-2i9fb2TPUDeKYzNImJ/QZF+9DDkRT0yIroLPXfI6aG4=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=v${finalAttrs.version}"
  ];

  meta = {
    description = "Fast, keyboard-driven Kubernetes TUI";
    homepage = "https://github.com/bjarneo/kli";
    changelog = "https://github.com/bjarneo/kli/releases/tag/v${finalAttrs.version}";
    maintainers = with lib.maintainers; [ kevinpita ];
    mainProgram = "kli";
    platforms = lib.platforms.unix;
  };
})
