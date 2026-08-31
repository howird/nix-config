{...}: {
  # howird-only (matches the pre-migration repo's home-manager/rclone.nix,
  # only ever imported by nixos-only.nix).
  den.aspects.rclone.homeManager = {pkgs, ...}: {
    home.packages = [pkgs.rclone];

    systemd.user.services.example-mounts = let
      gdrive-sync-dir = "gdrive";
    in {
      Unit = {
        Description = "Google Drive Mount with RClone";
        After = ["network-online.target"];
      };
      Service = {
        Type = "notify";
        ExecStartPre = "/usr/bin/env mkdir -p %h/${gdrive-sync-dir}";
        ExecStart = "${pkgs.rclone}/bin/rclone --vfs-cache-mode writes --ignore-checksum mount \"drive:\" \"${gdrive-sync-dir}\"";
        ExecStop = "/bin/fusermount -u %h/${gdrive-sync-dir}/%i";
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
