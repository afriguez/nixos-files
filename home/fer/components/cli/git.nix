{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "Fer L.";
      user.email = "afriguez@gmail.com";
      init.defaultBranch = "main";
    };
  };
}
