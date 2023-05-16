{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    git
    xplr
    firefox
    gparted
  ];

  programs.bash.shellAliases = {
    xcd = "cd \"$(xplr --print-pwd-as-result)\"";
  };

  services.sshd.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.sddm = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = "root";
  };
  services.xserver.desktopManager.plasma5.enable = true;

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  users.users.root.password = "nixos";
  services.openssh.settings.PermitRootLogin = lib.mkDefault "yes";
  services.getty.autologinUser = lib.mkDefault "root";
}