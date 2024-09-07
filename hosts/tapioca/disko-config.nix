{ ... }: {
  disko.devices = {
    disk = {
      tapioca = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
                type = "EF00";
                size = "500M";
                content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                };
            };
            root = {
              size = "100%";
                content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
