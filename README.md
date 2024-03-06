# nix-config

## first time

- Make the follwing changes the default nixos config with `sudoedit /etc/nixos/configuration.nix`
    - Add `nix.settings.experimental-features = "nix-command flakes";`
    - Add `git` to `environment.systemPackages`

- Apply the updates: `sudo nixos-rebuild switch`

- Clone this repo:

```bash
git clone https://github.com/howird/nix-config.git /home/howird/.config/nix
```

- Setup your system (remember to write the correct hostname):

```bash
sudo nixos-rebuild switch --flake .#<hostname>
home-manager switch --flake .#howird@<hostname>
```

## next times

```bash
nixwird
nixwird-hm
```
