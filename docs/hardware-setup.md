# Adding New Hard Drives to NixOS Hardware Configuration

1. First, identify your new drives and their UUIDs:
```bash
lsblk -f
```
Or for more detailed information:
```bash
sudo blkid
```

2. Once you have the UUID, add a new entry to the `fileSystems` section in your hardware configuration. Example:

```nix
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/YOUR-UUID-HERE";
    fsType = "ext4";  # or whatever filesystem you're using
  };
```

3. If you're adding multiple mount points, you can add multiple entries:

```nix
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/963ba2a3-2482-4e6d-86eb-64958e7c89a4";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/67D4-7894";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/mnt/data" = {
      device = "/dev/disk/by-uuid/YOUR-NEW-DRIVE-UUID";
      fsType = "ext4";
    };
    "/mnt/media" = {
      device = "/dev/disk/by-uuid/ANOTHER-DRIVE-UUID";
      fsType = "ext4";
      options = [ "nofail" ];  # Optional: system will boot even if drive isn't present
    };
  };
```

4. If adding swap partitions, add them to the swapDevices section:

```nix
  swapDevices = [ 
    { device = "/dev/disk/by-uuid/SWAP-PARTITION-UUID"; }
  ];
```

Remember to:
- Format your drives before adding them to the configuration
- Create the mount points (directories) if they don't exist
- Use UUIDs rather than device names (/dev/sdX) for reliability
- Consider adding options like "nofail" for external drives
- Run `nixos-rebuild switch` after updating the configuration