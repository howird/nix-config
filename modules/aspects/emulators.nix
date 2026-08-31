{...}: {
  den.aspects.emulators.nixos = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      dolphin-emu
      ryubing
    ];
  };
}
