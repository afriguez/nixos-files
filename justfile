set shell := ["bash", "-euo", "pipefail", "-c"]

default:
    @just --list

# Format the Marija-owned Nix files with the flake formatter.
fmt:
    nix fmt -- flake.nix hosts/marija/default.nix modules/nixos home/fer/default.nix home/fer/dotfiles.nix home/fer/packages.nix home/fer/programs home/fer/desktop

# Evaluate flake outputs without updating inputs or building closures.
check:
    nix flake check --no-build --no-write-lock-file

# Build Marija without creating a result symlink.
build:
    nix build --no-link --print-out-paths .#nixosConfigurations.marija.config.system.build.toplevel

# Activate Marija temporarily; a reboot returns to the previous generation.
test:
    nh os test . -H marija

# Build and make Marija the active boot generation.
switch:
    nh os switch . -H marija

# Refresh all flake inputs. Review flake.lock, then run check and build.
update:
    nix flake update
