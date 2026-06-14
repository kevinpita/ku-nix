{ lib
, buildGoModule
, fetchFromGitHub
,
}:

buildGoModule (finalAttrs: {
  pname = "kli";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "bjarneo";
    repo = "kli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Hr8pb5DHlkn5R0QLUIBbiQbZ4EG2V8urOzTduaa2b30=";
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
