{
  description = "Nix flake for kli, a fast keyboard-driven Kubernetes TUI";

  nixConfig = {
    extra-substituters = [ "https://kevinpita.cachix.org" ];
    extra-trusted-public-keys = [ "kevinpita.cachix.org-1:Cu9UtCDSfDq3/WDnI7N1N/LzAh90SPS+1R+nWao/hz0=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      overlay = final: prev: {
        kli = final.callPackage ./package.nix { };
      };
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };
        in
        {
          packages = {
            default = pkgs.kli;
            kli = pkgs.kli;
          };

          apps = {
            default = {
              type = "app";
              program = "${pkgs.kli}/bin/kli";
            };
            kli = {
              type = "app";
              program = "${pkgs.kli}/bin/kli";
            };
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              gh
              jq
              nixpkgs-fmt
            ];
          };
        }) // {
      overlays.default = overlay;
    };
}
