```
nix-collect-garbage -d &&
`echo BEFORE &&
date &&
echo AA &&
nix flake check &&
echo BB &&
export ARCHIVE=$(mktemp -d) && export RESOURCES=$(mktemp -d) && time nix run .#0-0-0 &&
echo CC &&
export ARCHIVE=$(mktemp -d) && export RESOURCES=$(mktemp -d) && time nix run .#0-0-1 &&
echo DD &&
export ARCHIVE=$(mktemp -d) && export RESOURCES=$(mktemp -d) && time nix run .#0-1-0 &&
echo EE &&
export ARCHIVE=$(mktemp -d) && export RESOURCES=$(mktemp -d) && `time nix run .#0-1-1` &&
echo FF &&
export ARCHIVE=$(mktemp -d) && export RESOURCES=$(mktemp -d) && ``time nix run .#1-0-0`` &&
echo GG &&
export ARCHIVE=$(mktemp -d) && export RESOURCES=$(mktemp -d) && time nix run .#1-0-1 `&&
echo HH &&
export ARCHIVE=$(mktemp -d) && export RESOURCES=$(mktemp -d) && time nix run .#1-1-0 &&
echo II &&
export ARCHIVE=$(mktemp -d) && export RESOURCES=$(mktemp -d) && time nix run .#1-1-1 &&
date &&
echo AFTER &&
git commit -am` "${@}" 
`
```