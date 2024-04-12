{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;
  networking.hostId = "8dabc8e2";

  networking.hostName = "FW16";
  networking.networkmanager.enable = true;

  services.openssh = {
    openFirewall = true;
    enable = true;
    settings = {
      PasswordAuthentication = lib.mkDefault false;
      KbdInteractiveAuthentication = lib.mkDefault false;
    };
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6Rb9XzpoStRNCqOeY7NCTprq/+NSlTiha6gDtslZJxX/YmmufoPtPwNA/F+32SFTCt2EXSoXhUL5/jzYH3+6uWdCVmZd1nSChCKV3AiyEJ7CK3I/41O7ljw3XoP2TtODnf6xSZKWUc3Eo2SEbuswzTE4yBJ5Pew3CvA1RUpqUDfFDFEi0RuzcbEx6zSbKQLDJja6v6s3dxijTNaFeH4JcnISx4X/3OjhRzmJ/44dcIjwjJwhDx/QkPRzm+HnthrjGUO3zrsX43NyNqfz9eu+YKT9iZmHIJlOKt1SCADDn3PspjXqrpb/LdYaAgjxLmK4bm7tIPryH5Xg6hKtTE7jJ sebastian@oldlaptop"
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  users.mutableUsers = true;
  users.users.nixos = {
    password = "nixos";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}

