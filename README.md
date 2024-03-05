# nix-config

- first time

```bash
git clone https://github.com/howird/nix-config.git /home/howird/.config/nix

sudo rm /etc/nixos/configuration.nix /etc/nixos/hardware-configuration.nix
sudo ln -s /home/howird/.config/nix/nixos/configuration.nix /etc/nixos/configuration.nix
sudo ln -s /home/howird/.config/nix/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo nixos-rebuild switch

cd ~/.config/nix
nix flake init
sudo nixos-rebuild switch --flake .
home-manager switch --flake .
```

- next times

```bash
nix-rs
nix-hm-rs
```
