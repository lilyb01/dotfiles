{ ... }: {
  disko.devices = {
    disk = {
      sda = {
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
            tapioca_root = {
              size = "100%";
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
