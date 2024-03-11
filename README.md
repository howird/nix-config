# nix-config

## first time

- Make the follwing changes the default nixos config with `sudoedit /etc/nixos/configuration.nix`
    - Add `nix.settings.experimental-features = "nix-command flakes";`
    - Add `git` to `environment.systemPackages`

- Apply the updates: `sudo nixos-rebuild switch`

- Clone this repo:

```bash
git clone https://github.com/howird/nix-config.git /home/howird/.config/nix
# or if you have your ssh keys:
git clone git@github.com:howird/nix-config /home/howird/.config/nix
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

## Configuring

### GNOME

- Should modify GNOME by

```bash
dconf dump / > old-conf.txt
```

- Modify using GNOME settings GUI, then:

```bash
dconf dump / > new-conf.txt
```

- Then compare the differences with:

```bash
code --diff old-conf.txt new-conf.txt
```

- Then update `./home-manager/gnome.nix`
