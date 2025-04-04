# GNOME and KDE Plasma

- We configure most of our settings declaratively using home-manager, so to update our desktop settings, we first cache our current settings with:

```bash
dconf dump / > old-conf.txt # GNOME
nix run .#rc2nix > old-conf.txt # KDE Plasma
```

- Modify using the settings GUI, then:

```bash
dconf dump / > new-conf.txt # GNOME
nix run .#rc2nix > new-conf.txt # KDE Plasma
```

- Then compare the differences with:

```bash
code --diff old-conf.txt new-conf.txt
```

- Then update `gnome.nix` or `kde.nix` accordingly in `./home-manager/desktops`

