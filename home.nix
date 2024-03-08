{config, pkgs, ...}:

{
  home.username = "ozen";
  home.homeDirectory = "/home/ozen";

  home.packages = with pkgs; [
    neofetch
  ];


  programs.git = {

     enable = true;
     userName = "kix300";
     userEmail = "kixwalkiki@gmail.com";

  };

  programs.starship = {
     enable = true;

     settings = {
       add_newline = false;
       aws.disabled = true;
       gcloud.disabled = true;
       line_break.disabled = true;
     };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

}
