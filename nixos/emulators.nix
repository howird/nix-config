{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dolphin-emu
    ryubing
    suyu
  ];
}
