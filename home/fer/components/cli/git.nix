{ ... }: {
  programs.git = {
    enable = true;
    userName = "Fer L.";
    userEmail = "afriguez@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
