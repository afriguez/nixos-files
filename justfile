set shell := ["bash", "-euo", "pipefail", "-c"]

default:
    @just --list

# Format the repository's Nix files with the flake formatter.
fmt:
    nix fmt -- flake.nix hosts modules home/fer/default.nix home/fer/dotfiles.nix home/fer/packages.nix home/fer/programs home/fer/desktop

# Evaluate flake outputs without updating inputs or building closures.
check:
    nix flake check --no-build --no-write-lock-file

# Build a host without creating a result symlink.
build host="marija":
    nix build --no-link --print-out-paths .#nixosConfigurations.{{host}}.config.system.build.toplevel

# Activate a host temporarily; a reboot returns to the previous generation.
test host="marija":
    nh os test . -H {{host}}

# Build and make a host the active boot generation.
switch host="marija":
    nh os switch . -H {{host}}

# Refresh all flake inputs. Review flake.lock, then run check and build.
update:
    nix flake update
