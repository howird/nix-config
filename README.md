# nix-config

## first time

- Make the follwing changes the default nixos config with `sudoedit /etc/nixos/configuration.nix`
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

### GNOME and KDE Plasma

- We configure most of our settings declaratively using home-manager, so to update our desktop settings, we first cache our current settings with:

```bash
dconf dump / > old-conf.txt # GNOME
nix run github:pjones/plasma-manager / > old-conf.txt # KDE Plasma
```

- Modify using the settings GUI, then:

```bash
dconf dump / > new-conf.txt # GNOME
nix run github:pjones/plasma-manager / > new-conf.txt # KDE Plasma
```

- Then compare the differences with:

```bash
code --diff old-conf.txt new-conf.txt
```

- Then update `gnome.nix` or `kde.nix` accordingly in `./home-manager/modules/desktops`
