# nix-config

### Initial System Setup

#### NixOS Machines:

- Make the follwing changes the default nixos config with
  `sudoedit /etc/nixos/configuration.nix`
  - Add `nix.settings.experimental-features = "nix-command flakes";`
  - Add `git` to `environment.systemPackages`

- Apply the updates: `sudo nixos-rebuild switch`

- Clone this repo:

```bash
mkdir /home/howird/nix
git clone https://github.com/howird/nix-config.git /home/howird/nix/config
# or if you have your ssh keys:
git clone git@github.com:howird/nix-config /home/howird/nix/config
```

- Apply this config

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

#### non-NixOS Machines:

- Install nix [here](https://nixos.org/download/)
- Install standalone home-manager, with
  [these commands](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone)
- Enable experimental features

```bash
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
```

- Apply this config

```bash
home-manager switch --flake .#howard@vip
```

## Next Times

```bash
nixwird
```

## troubleshooting

### main

- first try:

```bash
nix build nixpkgs#<pkg name>
eza --tree result/ --level 3
```

### cache/store related

- first try running with args:

```bash
nixwird --refresh --repair
```

- if nix store is broken:

```bash
sudo nix-collect-garbage -d
nix-store --verify --check-contents --repair
```

- if any derivations cannot be fixed with above command, try:

```bash
sudo nix-store --delete --ignore-liveness /nix/store/<derivation location>.drv
```

## Credits

- [FrostPhoenix](https://github.com/Frost-Phoenix/nixos-config) initial hyprland
  setup and ricing
- [Donovan Glover](https://github.com/donovanglover/nix-config) most other
  hyprland related stuff
