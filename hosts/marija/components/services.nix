{pkgs, ...}: {
  services = {
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
      };
    };
    xserver = {
      enable = true;
    };
    displayManager = {
      sddm = {
        package = pkgs.kdePackages.sddm;
        enable = true;
        theme = "where_is_my_sddm_theme";
        extraPackages = [
          pkgs.qt6.qt5compat
        ];
      };
    };
    postgresql = {
      enable = true;
      authentication = pkgs.lib.mkOverride 10 ''
        #type database DBuser auth-method
        local all      all    trust
        host  all all 127.0.0.1/32 trust
        host  all all ::1/128      trust
      '';
    };
  };
}
