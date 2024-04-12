{
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        #device = "/dev/nvme0n1";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_23509Q446109_1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            ESP2 = { # spare in case we need to install a second os or so
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = null;
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              end = "-100G";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                askPassword = true;
                settings = {
                  # if you want to use the key for interactive login be sure there is no trailing newline
                  # for example use `echo -n "password" > /tmp/secret.key`
                  #keyFile = "/tmp/secret.key";
                  allowDiscards = true; # TODO?
                  #crypttabExtraOpts = [ "tpm2-device=auto" ];
                };
                #additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                content = {
                  type = "zfs";
                  pool = "zroot";
                  # zpool = {
                  #   zroot = {
                  #     type = "zpool";
                  #     datasets = {
                  #       "root" = {
                  #         type = "zfs_fs";
                  #         options.mountpoint = "none";
                  #       };
                  #       "root/root" = {
                  #         type = "zfs_fs";
                  #         mountpoint = "/";
                  #         #options."com.sun:auto-snapshot" = "true";
                  #       };
                  #       "root/home" = {
                  #         type = "zfs_fs";
                  #         mountpoint = "/home";
                  #         #options."com.sun:auto-snapshot" = "true";
                  #       };
                  #       "root/nix" = {
                  #         type = "zfs_fs";
                  #         mountpoint = "/nix";
                  #         #options."com.sun:auto-snapshot" = "true";
                  #       };
                  #       "root/var" = {
                  #         type = "zfs_fs";
                  #         mountpoint = "/var";
                  #         #options."com.sun:auto-snapshot" = "true";
                  #       };
                  #     };
                  #   };
                  # };
                };
              };
            };
          };
        };
      };
    };
     zpool = {
       zroot = {
         type = "zpool";
         datasets = {
           "root" = {
             type = "zfs_fs";
             options.mountpoint = "none";
           };
           "root/root" = {
             type = "zfs_fs";
             mountpoint = "/";
             #options."com.sun:auto-snapshot" = "true";
           };
           "root/home" = {
             type = "zfs_fs";
             mountpoint = "/home";
             #options."com.sun:auto-snapshot" = "true";
           };
           "root/nix" = {
             type = "zfs_fs";
             mountpoint = "/nix";
             #options."com.sun:auto-snapshot" = "true";
           };
           "root/var" = {
             type = "zfs_fs";
             mountpoint = "/var";
             #options."com.sun:auto-snapshot" = "true";
           };
         };
       };
     };
  };
}
