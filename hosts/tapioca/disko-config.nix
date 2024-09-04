{ ... }: {
  disko.devices = {
    disks = {
      sda = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              start = "1MiB";
              end = "500MiB";
              bootable = true;
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            tapioca_root = {
              start = "500MiB";
              end = "100%";
              part-type = "primary";
              priority = 2;
              content = {
                type = "filesystem";
                format = "bcachefs";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
