# ku-nix

Always up-to-date Nix package for [ku](https://github.com/bjarneo/ku), a fast, keyboard-driven Kubernetes TUI.

## Quick Start

```bash
nix run github:kevinpita/ku-nix
```

## Install

```bash
nix profile install github:kevinpita/ku-nix
```

## Binary Cache

Prebuilt `x86_64-linux` outputs are served from a [Cachix](https://www.cachix.org/) cache, so installing pulls the binary instead of compiling ku locally. The flake advertises the cache via `nixConfig`; the first `nix run`/`nix profile install` will ask to trust it. To opt in permanently:

```bash
cachix use kevinpita
```

## Use In A Flake

### With the Cachix cache

Add the cache config to your consuming flake so Nix can fetch prebuilt `ku` outputs:

```nix
{
  nixConfig = {
    extra-substituters = [ "https://kevinpita.cachix.org" ];
    extra-trusted-public-keys = [ "kevinpita.cachix.org-1:Cu9UtCDSfDq3/WDnI7N1N/LzAh90SPS+1R+nWao/hz0=" ];
  };

  inputs.ku-nix.url = "github:kevinpita/ku-nix";

  outputs = { ku-nix, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          ku-nix.packages.${system}.default
        ];
      };
    };
}
```

Run with `--accept-flake-config` when prompted, or opt in globally with `cachix use kevinpita`.

### Without the Cachix cache

Omit `nixConfig`; Nix will build `ku` locally if it is not already available from your configured substituters:

```nix
{
  inputs.ku-nix.url = "github:kevinpita/ku-nix";

  outputs = { ku-nix, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          ku-nix.packages.${system}.default
        ];
      };
    };
}
```

## Development

```bash
nix build .#ku
./result/bin/ku --version
```

## Updates

The update workflow checks upstream releases hourly and can also be run manually from GitHub Actions. When a new release exists, it updates `package.nix`, refreshes the fixed-output hashes, creates a pull request, and enables auto-merge.

Manual update:

```bash
./scripts/update.sh --check
./scripts/update.sh --version 0.1.3
```
