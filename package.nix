{ lib
, buildGoModule
, fetchFromGitHub
,
}:

buildGoModule (finalAttrs: {
  pname = "ku";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "bjarneo";
    repo = "ku";
    tag = "v${finalAttrs.version}";
    hash = "sha256-pgcV0TxRg2brJXvuTUbiKzegYU0StV08kIyGf7VOeP8=";
  };

  vendorHash = "sha256-0gLwvJSEMgCw23YG8rMzoI7ubo0I5nvguex2HBJE1dU=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=v${finalAttrs.version}"
  ];

  meta = {
    description = "Fast, keyboard-driven Kubernetes TUI";
    homepage = "https://github.com/bjarneo/ku";
    changelog = "https://github.com/bjarneo/ku/releases/tag/v${finalAttrs.version}";
    maintainers = with lib.maintainers; [ kevinpita ];
    mainProgram = "ku";
    platforms = lib.platforms.unix;
  };
})
