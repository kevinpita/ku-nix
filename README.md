# kli-nix

Always up-to-date Nix package for [kli](https://github.com/bjarneo/kli), a fast, keyboard-driven Kubernetes TUI.

## Quick Start

```bash
nix run github:kevinpita/kli-nix
```

## Install

```bash
nix profile install github:kevinpita/kli-nix
```

## Binary Cache

Prebuilt `x86_64-linux` outputs are served from a [Cachix](https://www.cachix.org/) cache, so installing pulls the binary instead of compiling kli locally. The flake advertises the cache via `nixConfig`; the first `nix run`/`nix profile install` will ask to trust it. To opt in permanently:

```bash
cachix use kevinpita
```

## Use In A Flake

```nix
{
  inputs.kli-nix.url = "github:kevinpita/kli-nix";

  outputs = { kli-nix, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          kli-nix.packages.${system}.default
        ];
      };
    };
}
```

## Development

```bash
nix build .#kli
./result/bin/kli --version
```

## Updates

The update workflow checks upstream releases hourly and can also be run manually from GitHub Actions. When a new release exists, it updates `package.nix`, refreshes the fixed-output hashes, creates a pull request, and enables auto-merge.

Manual update:

```bash
./scripts/update.sh --check
./scripts/update.sh --version 0.1.3
```
